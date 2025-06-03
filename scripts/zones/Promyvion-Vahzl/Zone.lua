-----------------------------------
-- Zone: Promyvion-Vahzl (22)
-----------------------------------
local ID = zones[xi.zone.PROMYVION_VAHZL]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Define portal trigger areas.
    zone:registerCylindricalTriggerArea(1, 0, -120, 3) -- Floor 1: Exit Promyvion
    zone:registerCylindricalTriggerArea(2, -40, 200, 3) -- Floor 2: Return to floor 1
    zone:registerCylindricalTriggerArea(3, 320, -280, 3) -- Floor 3: Return to floor 2
    zone:registerCylindricalTriggerArea(4, 280, 40, 3) -- Floor 4: Return to floor 3
    zone:registerCylindricalTriggerArea(5, -40, 0, 3) -- Floor 5: Return to floor 4
    zone:registerCylindricalTriggerArea(6, -40, -360, 3) -- Floor 1: Portal S
    zone:registerCylindricalTriggerArea(7, 80, -40, 3) -- Floor 1: Portal N
    zone:registerCylindricalTriggerArea(8, -160, 200, 3) -- Floor 2: Portal N
    zone:registerCylindricalTriggerArea(9, -160, 120, 3) -- Floor 2: Portal S
    zone:registerCylindricalTriggerArea(10, 160, -160, 3) -- Floor 3: Portal W
    zone:registerCylindricalTriggerArea(11, 240, -40, 3) -- Floor 3: Portal N
    zone:registerCylindricalTriggerArea(12, 240, -240, 3) -- Floor 3: Portal S
    zone:registerCylindricalTriggerArea(13, 360, -80, 3) -- Floor 3: Portal E
    zone:registerCylindricalTriggerArea(14, 120, 40, 3) -- Floor 4: Portal SW
    zone:registerCylindricalTriggerArea(15, 440, 40, 3) -- Floor 4: Portal SE
    zone:registerCylindricalTriggerArea(16, 440, 279, 3) -- Floor 4: Portal NE

    -- Select portals.
    xi.promyvion.setupInitialPortals(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-14.744, 0.036, -119.736, 1) -- To Floor 1 (R)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:getTriggerAreaID()

    switch (triggerAreaID) : caseof {
        [1] = function() -- Floor 1: Exit promyvion
            player:startOptionalCutscene(45)
        end,

        [2] = function() -- Floor 2: Return to floor 1
            player:startOptionalCutscene(41)
        end,

        [3] = function() -- Floor 3: Return to floor 2
            player:startOptionalCutscene(42)
        end,

        [4] = function() -- Floor 4: Return to floor 3
            player:startOptionalCutscene(43)
        end,

        [5] = function() -- Floor 5: Return to floor 4
            player:startOptionalCutscene(44)
        end,

        [6] = function() -- Floor 1: Portal S
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 2, 32)
        end,

        [7] = function() -- Floor 1: Portal N
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 3, 33)
        end,

        [8] = function() -- Floor 2: Portal N
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET, 30)
        end,

        [9] = function() -- Floor 2: Portal S
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 1, 31)
        end,

        [10] = function() -- Floor 3: Portal W
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 5, 35)
        end,

        [11] = function() -- Floor 3: Portal N
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 6, 36)
        end,

        [12] = function() -- Floor 3: Portal S
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 7, 37)
        end,

        [13] = function() -- Floor 3: Portal E
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 8, 38)
        end,

        [14] = function() -- Floor 4: Portal SW
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 4, 34)
        end,

        [15] = function() -- Floor 4: Portal SE
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 9, 39)
        end,

        [16] = function() -- Floor 4: Portal NE
            xi.promyvion.handlePortal(player, ID.npc.MEMORY_STREAM_OFFSET + 10, 40)
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 45 and option == 1 then
        player:setPos(-379.947, 48.045, 334.059, 192, 9) -- To Pso'Xja (R)
    end
end

return zoneObject
