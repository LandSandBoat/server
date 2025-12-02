-----------------------------------
-- Zone: Aht_Urhgan_Whitegate (50)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1,   57, -1.0,  -70,   62,  1.0,  -65) -- Sets Mark for 'Got It All' Quest cutscene.
    zone:registerCuboidTriggerArea(2,  -96, -7.0,  121,  -64, -5.0,  137) -- Sets Mark for 'Vanishing Act' Quest cutscene.
    zone:registerCuboidTriggerArea(3,   31, -7.0,  -60,   39, -6.0,  -52) -- ToAU Mission 1, X region. Salaheem's Sentinels, second platform.
    zone:registerCuboidTriggerArea(4,   68, -1.0,   30,   91,  1.0,   53) -- ToAU Mission 4 region. Walahra Temple.
    zone:registerCuboidTriggerArea(5,   64, -7.0, -137,   95, -5.0, -123) -- ToAU Mission 4 region. Shaharat Teahouse.
    zone:registerCuboidTriggerArea(6,   30, -6.6,  -60,   39, -6.6,  -50) -- ToAU Mission 11 region. Salaheem's Sentinels, first platform.
    zone:registerCuboidTriggerArea(7,   69,  0.0,    7,   73,  0.0,   11) -- Sets Mark for 'Led Astry' Quest cutscene.
    zone:registerCuboidTriggerArea(8,   10,  2.0,  -96,   14,  2.0,  -92) -- Sets Mark for 'Led Astry' Quest cutscene.
    zone:registerCuboidTriggerArea(9, -103,  0.0,  -16, -100,  0.0,  -12) -- Sets Mark for 'Striking a Balance' Quest cutscene.
    zone:registerCuboidTriggerArea(10, -89,  0.0,   -8,  -71,  0.0,    8) -- Balrahn Way
    zone:registerCuboidTriggerArea(11,  22,  1.0, -100, 24.5,  3.0,  -98) -- The Prankster
    zone:registerCuboidTriggerArea(12,  25, -7.0, -127,   30, -5.0, -123) -- The Prankster
    zone:registerCuboidTriggerArea(13,  30, -7.0,  -51,   39, -5.0,  -40) -- Waking the Colossus/Divine Interference
end

zoneObject.onZoneIn = function(player, prevZone)
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.OPEN_SEA_ROUTE_TO_AL_ZAHBI then
            player:setPos(-11, 2, -142, 192)
            return 201
        elseif
            prevZone == xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI or
            prevZone == xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU
        then
            player:setPos(11, 2, 142, 64)
            return 204
        end
    end

    return xi.moghouse.onMoghouseZoneEvent(player, prevZone)
end

zoneObject.afterZoneIn = function(player)
    player:entityVisualPacket('1pb1')
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:getTriggerAreaID()): caseof
    {
        [1] = function() -- Cutscene for Got It All quest.
            if player:getCharVar('gotitallCS') == 5 then
                player:startEvent(526)
            end
        end,

        [2] = function() -- CS for Vanishing Act Quest
            if player:getCharVar('vanishingactCS') == 3 then
                player:startEvent(44)
            end
        end,

        [5] = function() -- AH mission
            if
                player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS) == xi.questStatus.QUEST_COMPLETED and
                player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS) == xi.questStatus.QUEST_AVAILABLE and
                player:getMainJob() == xi.job.COR and
                player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL
            then
                player:startEvent(797)
            end
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportId)
    -- Boat to Mhaura.
    if
        prevZoneId == xi.zone.OPEN_SEA_ROUTE_TO_AL_ZAHBI or
        prevZoneId == xi.zone.OPEN_SEA_ROUTE_TO_MHAURA
    then
        if player:hasKeyItem(xi.ki.FERRY_TICKET) then
            player:startEvent(200)
        else
            player:setPos(-11, 2, -142, 192)
        end

    -- Boat to Nashmau.
    elseif
        prevZoneId == xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU or
        prevZoneId == xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI
    then
        if player:hasKeyItem(xi.ki.SILVER_SEA_FERRY_TICKET) then
            player:startEvent(203)
        else
            player:setPos(11, 2, 142, 64)
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    -- This exist when boats leave among others. TODO: Add them. Things work better when they are added.
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 44 then
        player:setCharVar('vanishingactCS', 4)
        player:setPos(-80, -6, 122, 5)
    elseif csid == 200 then
        player:setPos(0, -2, 0, 0, xi.zone.OPEN_SEA_ROUTE_TO_MHAURA)
    elseif csid == 203 then
        player:setPos(0, -2, 0, 0, xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU)
    elseif csid == 526 then
        player:setCharVar('gotitallCS', 6)
        player:setPos(60, 0, -71, 38)
    elseif csid == 797 then
        player:setCharVar('AgainstAllOdds', 1)                                          -- Set For Corsair BCNM
        player:addQuest(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS) -- Start of af 3 not completed yet
        npcUtil.giveKeyItem(player, xi.ki.LIFE_FLOAT)
        player:setCharVar('AgainstAllOddsTimer', JstMidnight())
    end
end

return zoneObject
