-----------------------------------
-- Zone: Promyvion-Vahzl (22)
-----------------------------------
local ID = zones[xi.zone.PROMYVION_VAHZL]
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Define portal trigger areas.
    zone:registerTriggerArea(1,     0, 3, -120, 0, 0, 0) -- Floor 1: Exit Promyvion
    zone:registerTriggerArea(2,   -40, 3,  200, 0, 0, 0) -- Floor 2: Return to floor 1
    zone:registerTriggerArea(3,   320, 3, -280, 0, 0, 0) -- Floor 3: Return to floor 2
    zone:registerTriggerArea(4,   280, 3,   40, 0, 0, 0) -- Floor 4: Return to floor 3
    zone:registerTriggerArea(5,   -40, 3,    0, 0, 0, 0) -- Floor 5: Return to floor 4
    zone:registerTriggerArea(6,   -40, 3, -360, 0, 0, 0) -- Floor 1: Portal S
    zone:registerTriggerArea(7,    80, 3,  -40, 0, 0, 0) -- Floor 1: Portal N
    zone:registerTriggerArea(8,  -160, 3,  200, 0, 0, 0) -- Floor 2: Portal N
    zone:registerTriggerArea(9,  -160, 3,  120, 0, 0, 0) -- Floor 2: Portal S
    zone:registerTriggerArea(10,  160, 3, -160, 0, 0, 0) -- Floor 3: Portal W
    zone:registerTriggerArea(11,  240, 3,  -40, 0, 0, 0) -- Floor 3: Portal N
    zone:registerTriggerArea(12,  240, 3, -240, 0, 0, 0) -- Floor 3: Portal S
    zone:registerTriggerArea(13,  360, 3,  -80, 0, 0, 0) -- Floor 3: Portal E
    zone:registerTriggerArea(14,  120, 3,   40, 0, 0, 0) -- Floor 4: Portal SW
    zone:registerTriggerArea(15,  440, 3,   40, 0, 0, 0) -- Floor 4: Portal SE
    zone:registerTriggerArea(16,  440, 3,  279, 0, 0, 0) -- Floor 4: Portal NE

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
    local triggerAreaID = triggerArea:GetTriggerAreaID()

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
