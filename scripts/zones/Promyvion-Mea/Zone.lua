-----------------------------------
-- Zone: Promyvion-Mea (20)
-----------------------------------
local ID = zones[xi.zone.PROMYVION_MEA]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Define portal trigger areas.
    zone:registerCylindricalTriggerArea(1, -120, 200, 3) -- Floor 1: Exit Promyvion
    zone:registerCylindricalTriggerArea(2, 0, -120, 3) -- Floor 2: Return to floor 1
    zone:registerCylindricalTriggerArea(3, -160, 160, 3) -- Floor 3 (West): Return to floor 2
    zone:registerCylindricalTriggerArea(4, 160, -280, 3) -- Floor 3 (East): Return to floor 2
    zone:registerCylindricalTriggerArea(5, -80, 360, 3) -- Floor 4: Return to floor 3 East or West
    zone:registerCylindricalTriggerArea(6, -280, 240, 3) -- Floor 1: Portal
    zone:registerCylindricalTriggerArea(7, -80, -40, 3) -- Floor 2: Portal N  - Destination: East
    zone:registerCylindricalTriggerArea(8, -320, -360, 3) -- Floor 2: Portal SW - Destination: West
    zone:registerCylindricalTriggerArea(9, -40, -320, 3) -- Floor 2: Portal S  - Destination: West
    zone:registerCylindricalTriggerArea(10, 80, -240, 3) -- Floor 2: Portal SE - Destination: East
    zone:registerCylindricalTriggerArea(11, -320, -40, 3) -- Floor 3 (West): Portal SW
    zone:registerCylindricalTriggerArea(12, -240, -40, 3) -- Floor 3 (West): Portal S
    zone:registerCylindricalTriggerArea(13, -40, 0, 3) -- Floor 3 (West): Portal SE
    zone:registerCylindricalTriggerArea(14, 200, 0, 3) -- Floor 3 (East): Portal NW
    zone:registerCylindricalTriggerArea(15, 360, -40, 3) -- Floor 3 (East): Portal NE
    zone:registerCylindricalTriggerArea(16, 240, -320, 3) -- Floor 3 (East): Portal SW

    -- Select portals.
    xi.promyvion.setupInitialPortals(zone)

    -- Update NM between Floor 3 islands.
    UpdateNMSpawnPoint(ID.mob.COVETER)
    GetMobByID(ID.mob.COVETER):setRespawnTime(math.random(3600, 21600))
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-93.268, 0, 170.749, 162) -- Floor 1 (R)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:getTriggerAreaID()

    switch (triggerAreaID) : caseof {
        [1] = function() -- Floor 1: Exit promyvion
            player:startOptionalCutscene(46)
        end,

        [2] = function() -- Floor 2: Return to floor 1
            player:startOptionalCutscene(41)
        end,

        [3] = function() -- Floor 3 (West): Return to floor 2
            player:startOptionalCutscene(42)
        end,

        [4] = function() -- Floor 3 (East): Return to floor 2
            player:startOptionalCutscene(43)
        end,

        [5] = function() -- Floor 4: Return to floor 3 East or West
            -- Event 44 -> Return to floor 3 West
            -- Event 45 -> Return to floor 3 East
            player:startOptionalCutscene(44 + player:getCharVar('[Mea]ReturnEast'))
        end,

        [6] = function() -- Floor 1: Portal
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET, 30)
        end,

        [7] = function() -- Floor 2: Portal N  - Destination: East
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 3, 33)
        end,

        [8] = function() -- Floor 2: Portal SW - Destination: West
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 7, 37)
        end,

        [9] = function() -- Floor 2: Portal S  - Destination: West
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 8, 38)
        end,

        [10] = function() -- Floor 2: Portal SE - Destination: East
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 9, 39)
        end,

        [11] = function() -- Floor 3 (West): Portal SW
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 1, 31)
        end,

        [12] = function() -- Floor 3 (West): Portal S
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 2, 32)
        end,

        [13] = function() -- Floor 3 (West): Portal SE
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 4, 34)
        end,

        [14] = function() -- Floor 3 (East): Portal NW
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 5, 35)
        end,

        [15] = function() -- Floor 3 (East): Portal NE
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 6, 36)
        end,

        [16] = function() -- Floor 3 (East): Portal SW
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 10, 40)
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    switch (csid) : caseof {
        [31] = function() -- Floor 3 (West) to floor 4
            if option == 1 then
                player:setCharVar('[Mea]ReturnEast', 0)
            end
        end,

        [32] = function() -- Floor 3 (West) to floor 4
            if option == 1 then
                player:setCharVar('[Mea]ReturnEast', 0)
            end
        end,

        [34] = function() -- Floor 3 (West) to floor 4
            if option == 1 then
                player:setCharVar('[Mea]ReturnEast', 0)
            end
        end,

        [35] = function() -- Floor 3 (East) to floor 4
            if option == 1 then
                player:setCharVar('[Mea]ReturnEast', 1)
            end
        end,

        [36] = function() -- Floor 3 (East) to floor 4
            if option == 1 then
                player:setCharVar('[Mea]ReturnEast', 1)
            end
        end,

        [40] = function() -- Floor 3 (East) to floor 4
            if option == 1 then
                player:setCharVar('[Mea]ReturnEast', 1)
            end
        end,

        [44] = function() -- Floor 4: Return to floor 3 (West)
            if option == 1 then
                player:setCharVar('[Mea]ReturnEast', 0)
            end
        end,

        [45] = function() -- Floor 4: Return to floor 3 (East)
            if option == 1 then
                player:setCharVar('[Mea]ReturnEast', 0)
            end
        end,

        [46] = function() -- Floor 1: Exit promyvion
            if option == 1 then
                player:setCharVar('[Mea]ReturnEast', 0)
                player:setPos(279.988, -86.459, -25.994, 63, 14) -- To Hall of Transferance (R)
            end
        end,
    }
end

return zoneObject
