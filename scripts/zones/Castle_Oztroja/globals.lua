-- Zone: Castle Oztroja (151)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------

local oztrojaGlobal =
{
    --[[..............................................................................................
        pick a new handle combination for the brass door on floor 2
        ..............................................................................................]]
    pickNewCombo = function()
        local numOpen
        local combo = {}

        -- https://ffxiclopedia.wikia.com/wiki/Talk:Castle_Oztroja
        -- "the combination seems to always be two levers up and two levers down."
        -- "False. I just had a combo that was [Up, Up, Down, Up]. It isn't always 2 up and 2 down."
        -- Let's interpret this to mean a valid combination has at least two levers up (open)

        repeat
            numOpen = 0
            for i = 0, 3 do
                local correctState = xi.anim.OPEN_DOOR + math.random(0, 1)
                combo[i] = correctState
                if correctState == xi.anim.OPEN_DOOR then
                    numOpen = numOpen + 1
                end
            end
        until numOpen >= 2

        -- set combination
        for i = 0, 3 do
            local realLever = GetNPCByID(ID.npc.HANDLE_DOOR_FLOOR_2 + 2 + i)
            local hintLever = GetNPCByID(ID.npc.HINT_HANDLE_OFFSET + i)

            if realLever and hintLever then
                realLever:setAnimation(xi.anim.CLOSE_DOOR)
                hintLever:setAnimation(combo[i])
            end
        end
    end,

    --[[..............................................................................................
        pick a new password for the trap door on floor 4
        ..............................................................................................]]
    pickNewPassword = function()
        GetNPCByID(ID.npc.TRAP_DOOR_FLOOR_4):setLocalVar('password', math.random(0, 8))
    end,

    --[[..............................................................................................
        player toggles a lever next to the brass door on floor 2
        ..............................................................................................]]
    handleOnTrigger = function(npc)
        -- toggle the lever
        if npc:getAnimation() == xi.anim.CLOSE_DOOR then
            npc:setAnimation(xi.anim.OPEN_DOOR)
        else
            npc:setAnimation(xi.anim.CLOSE_DOOR)
        end

        npc:timer(1500, function(npcArg)
            local comboFound = true
            for i = 0, 3 do
                local realLever = GetNPCByID(ID.npc.HANDLE_DOOR_FLOOR_2 + 2 + i)
                local hintLever = GetNPCByID(ID.npc.HINT_HANDLE_OFFSET + i)

                if
                    realLever and
                    hintLever and
                    realLever:getAnimation() ~= hintLever:getAnimation()
                then
                    comboFound = false
                    break
                end
            end

            if comboFound then
                GetNPCByID(ID.npc.HANDLE_DOOR_FLOOR_2):openDoor(6)
                for i = 0, 3 do
                    GetNPCByID(ID.npc.HANDLE_DOOR_FLOOR_2 + 2 + i):setAnimation(xi.anim.CLOSE_DOOR)
                end
            end
        end)
    end,
}

return oztrojaGlobal
