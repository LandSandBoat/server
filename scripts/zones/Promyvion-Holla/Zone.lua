-----------------------------------
-- Zone: Promyvion-Holla (16)
-----------------------------------
local ID = zones[xi.zone.PROMYVION_HOLLA]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Define portal trigger areas.
    zone:registerCylindricalTriggerArea(1, 80, 80, 3) -- Floor 1: Exit Promyvion
    zone:registerCylindricalTriggerArea(2, -120, 0, 3) -- Floor 2: Return to floor 1
    zone:registerCylindricalTriggerArea(3, -160, 120, 3) -- Floor 3 (West): Return to floor 2
    zone:registerCylindricalTriggerArea(4, 160, 240, 3) -- Floor 3 (East): Return to floor 2
    zone:registerCylindricalTriggerArea(5, 120, -320, 3) -- Floor 4: Return to floor 3 East or West
    zone:registerCylindricalTriggerArea(6, -40, 200, 3) -- Floor 1: Portal
    zone:registerCylindricalTriggerArea(7, -240, 40, 3) -- Floor 2: Portal NW - Destination: East
    zone:registerCylindricalTriggerArea(8, -280, -40, 3) -- Floor 2: Portal SW - Destination: West
    zone:registerCylindricalTriggerArea(9, -160, -200, 3) -- Floor 2: Portal SE - Destination: East
    zone:registerCylindricalTriggerArea(10, 0, -40, 3) -- Floor 2: Portal NE - Destination: West
    zone:registerCylindricalTriggerArea(11, -280, 280, 3) -- Floor 3 (West): Portal NE
    zone:registerCylindricalTriggerArea(12, -360, 240, 3) -- Floor 3 (West): Portal NW
    zone:registerCylindricalTriggerArea(13, -360, 120, 3) -- Floor 3 (West): Portal SW
    zone:registerCylindricalTriggerArea(14, 40, 320, 3) -- Floor 3 (East): Portal NW
    zone:registerCylindricalTriggerArea(15, 160, 360, 3) -- Floor 3 (East): Portal NE
    zone:registerCylindricalTriggerArea(16, 280, 200, 3) -- Floor 3 (East): Portal SE

    -- Select portals.
    xi.promyvion.setupInitialPortals(zone)

    -- Update NM between Floor 3 islands.
    UpdateNMSpawnPoint(ID.mob.CEREBRATOR)
    GetMobByID(ID.mob.CEREBRATOR):setRespawnTime(math.random(3600, 21600))
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(92.033, 0, 80.380, 255) -- To Floor 1 (R)
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
            player:startOptionalCutscene(45)
        end,

        [5] = function() -- Floor 4: Return to floor 3 East or West
            -- Event 43 -> Return to floor 3 East
            -- Event 44 -> Return to floor 3 West
            player:startOptionalCutscene(43 + player:getCharVar('[Holla]ReturnWest'))
        end,

        [6] = function() -- Floor 1: Portal
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 7, 37)
        end,

        [7] = function() -- Floor 2: Portal NW - Destination: East
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 3, 33)
        end,

        [8] = function() -- Floor 2: Portal SW - Destination: West
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 4, 34)
        end,

        [9] = function() -- Floor 2: Portal SE - Destination: East
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 5, 35)
        end,

        [10] = function() -- Floor 2: Portal NE - Destination: West
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 6, 36)
        end,

        [11] = function() -- Floor 3 (West): Portal NE
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET, 30)
        end,

        [12] = function() -- Floor 3 (West): Portal NW
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 1, 31)
        end,

        [13] = function() -- Floor 3 (West): Portal SW
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 2, 32)
        end,

        [14] = function() -- Floor 3 (East): Portal NW
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 8, 38)
        end,

        [15] = function() -- Floor 3 (East): Portal NE
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 9, 39)
        end,

        [16] = function() -- Floor 3 (East): Portal SE
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
        [30] = function() -- Floor 3 (West): Portal NE
            if option == 1 then
                player:setCharVar('[Holla]ReturnWest', 1)
            end
        end,

        [31] = function() -- Floor 3 (West): Portal NW
            if option == 1 then
                player:setCharVar('[Holla]ReturnWest', 1)
            end
        end,

        [32] = function() -- Floor 3 (West): Portal SW
            if option == 1 then
                player:setCharVar('[Holla]ReturnWest', 1)
            end
        end,

        [38] = function() -- Floor 3 (East): Portal NW
            if option == 1 then
                player:setCharVar('[Holla]ReturnWest', 0)
            end
        end,

        [39] = function() -- Floor 3 (East): Portal NE
            if option == 1 then
                player:setCharVar('[Holla]ReturnWest', 0)
            end
        end,

        [40] = function() -- Floor 3 (East): Portal SE
            if option == 1 then
                player:setCharVar('[Holla]ReturnWest', 0)
            end
        end,

        [43] = function() -- Floor 4: Return to floor 3 (East)
            if option == 1 then
                player:setCharVar('[Holla]ReturnWest', 0)
            end
        end,

        [44] = function() -- Floor 4: Return to floor 3 (West)
            if option == 1 then
                player:setCharVar('[Holla]ReturnWest', 0)
            end
        end,

        [46] = function() -- Floor 1: Exit promyvion
            if option == 1 then
                player:setCharVar('[Holla]ReturnWest', 0)
                player:setPos(-225.682, -6.459, 280.002, 128, 14) -- To Hall of Transference (R)
            end
        end,
    }
end

return zoneObject
