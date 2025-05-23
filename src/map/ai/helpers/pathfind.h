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

#ifndef _PATHFIND_H
#define _PATHFIND_H

#include "common/logging.h"
#include "common/mmo.h"
#include "common/timer.h"

#include <vector>

class CBaseEntity;

// no path can be longer than this
#define MAX_PATH_POINTS     50
#define MAX_TURN_POINTS     5
#define VERTICAL_PATH_LIMIT 3.5

enum PATHFLAG
{
    PATHFLAG_NONE     = 0x00,
    PATHFLAG_RUN      = 0x01, // run twice the speed
    PATHFLAG_WALLHACK = 0x02, // run through walls if path is too long
    PATHFLAG_REVERSE  = 0x04, // reverse the path
    PATHFLAG_SCRIPT   = 0x08, // don't overwrite this path before completion (except via another script)
    PATHFLAG_SLIDE    = 0x10, // Slide to end point if close enough (so no over shoot)
    PATHFLAG_PATROL   = 0x20, // Automatically restart path once it is finished and resume when roaming
    PATHFLAG_COORDS   = 0x40, // Follows path until end, but will not repeat
};

class CPathFind
{
public:
    CPathFind(CBaseEntity* PTarget);
    ~CPathFind();

    // move to a random point around given point
    bool RoamAround(const position_t& point, float maxRadius, uint8 maxTurns, uint16 roamFlags = 0);

    // find and walk to the given point
    bool PathTo(const position_t& point, uint8 pathFlags = 0, bool clear = true);
    // walk to the given point until in range
    bool PathInRange(const position_t& point, float range, uint8 pathFlags = 0, bool clear = true);

    // move some where around the point
    bool PathAround(const position_t& point, float distanceFromPoint, uint8 pathFlags = 0);

    // walk through the given points. No new points made.
    bool PathThrough(std::vector<pathpoint_t>&& points, uint8 pathFlags = 0);

    // instantly moves an entity to the point
    // this will make sure you're not in a wall
    bool WarpTo(const position_t& point, float maxDistance = 2.0f);

    void ResumePatrol();

    // moves mob to next point
    void FollowPath(timer::time_point tick);

    // returns true if entity is on a way point
    bool OnPoint() const;

    // stops pathfinding after moving the given distance
    // this can be used to prevent mobs from walking
    // all the way to a point
    void LimitDistance(float maxDistance);

    // Prunes the last points of a path, if they are within the given distance
    void PrunePathWithin(float within);

    // tells entity to take one step towards position
    void StepTo(const position_t& pos, bool run = false);

    // checks if mob is currently following a path
    bool IsFollowingPath();
    bool IsFollowingScriptedPath();
    bool IsPatrolling();

    // look at the given point
    void LookAt(const position_t& point);

    // clear current path
    void Clear();
    bool isNavMeshEnabled();

    bool ValidPosition(const position_t& pos);

    // checks if mob is at given point
    bool AtPoint(const position_t& pos);

    // returns true if i'm in water
    bool InWater();

    // returns the final destination of the current path
    const position_t& GetDestination() const;

    // If careful pathing is set, the owner will continually be "snapped" back
    // onto a valid poly every time FollowPath() is called.
    // THIS IS 4-5x MORE EXPENSIVE THAN A REGULAR CALL TO FollowPath()!
    // YOU HAVE BEEN WARNED!
    void SetCarefulPathing(bool careful);

private:
    // find a valid path using polys
    bool FindPath(const position_t& start, const position_t& end);

    // cut some corners and find the fastest path
    // this will make the mob run down cliffs
    bool FindClosestPath(const position_t& start, const position_t& end);

    // finds a random path around the given point
    bool FindRandomPath(const position_t& start, float maxRadius, uint8 maxTurns, uint16 roamFlags);

    void AddPoints(std::vector<pathpoint_t>&& points, bool reverse = false);

    void FinishedPath();

    CBaseEntity*             m_POwner;
    std::vector<pathpoint_t> m_points;
    std::vector<pathpoint_t> m_patrol;
    std::vector<position_t>  m_turnPoints;
    position_t               m_originalPoint;
    float                    m_distanceFromPoint;

    uint8  m_pathFlags;
    uint8  m_patrolFlags;
    uint16 m_roamFlags;
    bool   m_onPoint;
    int16  m_currentPoint;

    timer::time_point m_timeAtPoint;

    uint8 m_currentTurn;

    float m_distanceMoved;
    float m_maxDistance;

    bool m_carefulPathing;
};

#endif
