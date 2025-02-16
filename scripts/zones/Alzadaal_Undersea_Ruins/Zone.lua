-----------------------------------
-- Zone: Alzadaal_Undersea_Ruins (72)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -329, -2, 483, -323, 0, 489)    -- map 1 SE porter
    zone:registerCuboidTriggerArea(2, -477, -2, 631, -471, 0, 636)    -- map 1 NW porter
    zone:registerCuboidTriggerArea(3,  110, -2, -556, 116, 0, -551)   -- map 2 west porter (white)
    zone:registerCuboidTriggerArea(4,   30, -2, 750,  36, 0, 757)     -- map 3 west porter (blue)
    zone:registerCuboidTriggerArea(5,   83, -2, 750,  90, 0, 757)     -- map 3 east porter (white)
    zone:registerCuboidTriggerArea(6, -329, -2, 150, -323, 0, 156)    -- map 4 porter (white)
    zone:registerCuboidTriggerArea(7, -208, -2, -556, -202, 0, -551)  -- map 5 porter (white)
    zone:registerCuboidTriggerArea(8,  323, -2, 591, 329, 0, 598)     -- map 6 east porter (white)
    zone:registerCuboidTriggerArea(9,  270, -2, 591, 276, 0, 598)     -- map 6 west porter (blue)
    zone:registerCuboidTriggerArea(11, -63, -10,  56, -57, -8,  62)   -- map 8 NW/Arrapago porter
    zone:registerCuboidTriggerArea(12,  17, -6,  56,  23, -4,  62)    -- map 8 NE/Silver Sea/Khim porter
    zone:registerCuboidTriggerArea(13, -63, -10, -23, -57, -8, -16)   -- map 8 SW/Zhayolm/bird camp porter
    zone:registerCuboidTriggerArea(14,  17, -6, -23,  23, -4, -16)    -- map 8 SE/Bhaflau Porter
    zone:registerCuboidTriggerArea(15, -556, -2, -77, -550, 0, -71)   -- map 9 east porter (white)
    zone:registerCuboidTriggerArea(16, -609, -2, -77, -603, 0, -71)   -- map 9 west porter (blue)
    zone:registerCuboidTriggerArea(17, 643, -2, -289, 649, 0, -283)   -- map 10 east porter (blue)
    zone:registerCuboidTriggerArea(18, 590, -2, -289, 597, 0, -283)   -- map 10 west porter (white)
    zone:registerCuboidTriggerArea(19, 603, -2, 522, 610, 0, 529)     -- map 11 east porter (blue)
    zone:registerCuboidTriggerArea(20, 550, -2, 522, 557, 0, 529)     -- map 11 west porter (white)
    zone:registerCuboidTriggerArea(21, -556, -2, -489, -550, 0, -483) -- map 12 east porter (white)
    zone:registerCuboidTriggerArea(22, -610, -2, -489, -603, 0, -483) -- map 12 west porter (blue)
    zone:registerCuboidTriggerArea(23, 394, -1, -619, 487, 1, -540)   -- map 7, Whole zone right before the door (as per BG-Wiki). https://www.bg-wiki.com/ffxi/Aht_Urhgan_Mission_9. ToAU mission 9.
    zone:registerCuboidTriggerArea(24,  52, -1, 774, 67, 1, 778)      -- transformations (quest)
    zone:registerCuboidTriggerArea(25, 134, -1, -584, 146, 1, -577)   -- transformations (quest)
    zone:registerCuboidTriggerArea(26, 442, -2, -557, 450, 0, -550)   -- map 7 porter (white) (moved after region 23 to avoid spamming events)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.ARRAPAGO_REMNANTS then
            player:setPos(-579, 0.05, -100, 192)
        else
            player:setPos(222.798, -0.5, 19.872, 0)
        end
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    player:entityVisualPacket('1pa1')
    player:entityVisualPacket('1pb1')
    player:entityVisualPacket('2pb1')
end

-- TODO: Table teleporter events keyed by triggerArea and perform a direct
-- lookup.
zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:getTriggerAreaID()): caseof
    {
        [1] = function(x)
            player:startEvent(204)
        end,

        [2] = function(x)
            player:startEvent(205)
        end,

        [3] = function(x)
            player:startEvent(201)
        end,

        [4] = function(x)
            player:startEvent(203)
        end,

        [5] = function(x)
            player:startEvent(202)
        end,

        [6] = function(x)
            player:startEvent(206)
        end,

        [7] = function(x)
            player:startEvent(211)
        end,

        [8] = function(x)
            player:startEvent(200)
        end,

        [9] = function(x)
            player:startEvent(201)
        end,

        [26] = function(x)
            player:startEvent(213)
        end,

        [11] = function(x)
            player:startEvent(218)
        end,

        [12] = function(x)
            player:startEvent(221)
        end,

        [13] = function(x)
            player:startEvent(219)
        end,

        [14] = function(x)
            player:startEvent(220)
        end,

        [15] = function(x)
            player:startEvent(207)
        end,

        [16] = function(x)
            player:startEvent(208)
        end,

        [17] = function(x)
            player:startEvent(214)
        end,

        [18] = function(x)
            player:startEvent(207)
        end,

        [19] = function(x)
            player:startEvent(202)
        end,

        [20] = function(x)
            player:startEvent(207)
        end,

        [21] = function(x)
            player:startEvent(207)
        end,

        [22] = function(x)
            player:startEvent(210)
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 1 and option == 10 then -- start
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    elseif csid == 1 and option == 1 then -- windows
        player:setLocalVar('UnderseaScouting', player:getLocalVar('UnderseaScouting') + 1)
        player:updateEvent(player:getLocalVar('UnderseaScouting'), 0, 0, 0, 0, 0, 0, 0)
    elseif csid == 1 and option == 2 then -- pillars
        player:setLocalVar('UnderseaScouting', player:getLocalVar('UnderseaScouting') + 2)
        player:updateEvent(player:getLocalVar('UnderseaScouting'), 0, 0, 0, 0, 0, 0, 0)
    elseif csid == 1 and option == 3 then -- floor
        player:setLocalVar('UnderseaScouting', player:getLocalVar('UnderseaScouting') + 4)
        player:updateEvent(player:getLocalVar('UnderseaScouting'), 0, 0, 0, 0, 0, 0, 0)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 116 and player:getLocalVar('SalvageArrapago') == 1 then -- enter Salvage Silver Sea zone
        player:setPos(0, 0, 0, 0, 74)
    elseif csid == 116 and player:getLocalVar('SalvageSilverSea') == 1 then -- enter Salvage Arrapago zone
        player:setPos(0, 0, 0, 0, 76)
    elseif csid == 116 and player:getLocalVar('Nyzul') == 1 then -- enter instanced nyzul isle zone
        player:setPos(0, 0, 0, 0, 77)
    end
end

return zoneObject
