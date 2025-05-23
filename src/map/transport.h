﻿/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#ifndef _CTRANSPORT_H
#define _CTRANSPORT_H

#include "common/cbasetypes.h"
#include "common/ipp.h"
#include "common/singleton.h"
#include "common/vana_time.h"

#include "entities/npcentity.h"

#include <vector>

enum TRANSPORTSTATE
{
    STATE_TRANSPORT_INIT = 0,
    STATE_TRANSPORT_ARRIVING,
    STATE_TRANSPORT_DOCKED,
    STATE_TRANSPORT_DEPARTING,
    STATE_TRANSPORT_AWAY
};

enum TRANSPORTZONESTATE
{
    STATE_TRANSPORTZONE_INIT = 0,
    STATE_TRANSPORTZONE_VOYAGE,
    STATE_TRANSPORTZONE_EVICT,
    STATE_TRANSPORTZONE_WAIT,
    STATE_TRANSPORTZONE_DOCKED
};

enum ELEVATORSTATE
{
    STATE_ELEVATOR_BOTTOM = 0,
    STATE_ELEVATOR_TOP,
    STATE_ELEVATOR_ASCEND,
    STATE_ELEVATOR_DESCEND
};

struct Transport_Time
{
    vanadiel_time::duration timeOffset;
    vanadiel_time::duration timeInterval;
    vanadiel_time::duration timeArriveDock;
    vanadiel_time::duration timeDepartDock;
    vanadiel_time::duration timeVoyageStart;
};

struct Transport_Ship : Transport_Time
{
    uint8 animationArrive;
    uint8 animationDepart;
    uint8 state;

    CBaseEntity* npc;
    location_t   dock;

    void setVisible(bool) const;
    void animateSetup(uint8, vanadiel_time::time_point) const;
    void spawn() const;
};

struct TransportZone_Town
{
    Transport_Ship ship;

    CBaseEntity* npcDoor;

    void updateShip() const;
    void openDoor(bool) const;
    void closeDoor(bool) const;
    void depart() const;
};

struct TransportZone_Voyage : Transport_Time
{
    CZone* voyageZone;
    uint8  state;
};

struct Elevator_t
{
    uint8 id;
    uint8 state;

    uint16                    zoneID;
    vanadiel_time::time_point lastTrigger;

    vanadiel_time::duration interval;
    vanadiel_time::duration movetime;

    CNpcEntity* Elevator;
    CNpcEntity* LowerDoor;
    CNpcEntity* UpperDoor;

    bool activated;
    bool isPermanent;
    bool animationsReversed;

    void closeDoor(CNpcEntity*) const;
    void openDoor(CNpcEntity*) const;
};

class CTransportHandler : public Singleton<CTransportHandler>
{
public:
    void startElevator(int32 elevatorID);
    void TransportTimer();
    void insertElevator(Elevator_t elevator);

    Elevator_t* getElevator(uint8 elevatorID);

    void InitializeTransport(IPP mapIPP);

protected:
    CTransportHandler() = default;

private:
    void startElevator(Elevator_t*);
    void arriveElevator(Elevator_t*);

    std::vector<Elevator_t>           ElevatorList;
    std::vector<TransportZone_Town>   townZoneList;
    std::vector<TransportZone_Voyage> voyageZoneList;
};

#endif
