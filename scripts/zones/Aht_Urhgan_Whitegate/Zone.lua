-----------------------------------
-- Zone: Aht_Urhgan_Whitegate (50)
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1,  57, -1,  -70,  62,  1,  -65) -- Sets Mark for "Got It All" Quest cutscene.
    zone:registerRegion(2, -96, -7,  121, -64, -5,  137) -- Sets Mark for "Vanishing Act" Quest cutscene.
    zone:registerRegion(3,  20, -8,  -51,  39, -6,  -40) -- TOAU Mission 1 CS area
    zone:registerRegion(4,  75, -3,   25,  90,  1,   59)
    zone:registerRegion(5,  73, -7, -137,  95, -3, -115) -- entering Shaharat Teahouse
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        if (prevZone == xi.zone.OPEN_SEA_ROUTE_TO_AL_ZAHBI) then
            cs = 201
        elseif (prevZone == xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI) then
            cs = 204
        elseif (prevZone == xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU) then
            cs = 204
        else
            -- MOG HOUSE EXIT
            local position = math.random(1, 5) - 83
            player:setPos(-100, 0, position, 0)
        end
    end

    return cs
end

zone_object.afterZoneIn = function(player)
    player:entityVisualPacket("1pb1")
end

zone_object.onRegionEnter = function(player, region)
    local toauMission = player:getCurrentMission(TOAU)

    switch (region:GetRegionID()): caseof
    {
        [1] = function (x)  -- Cutscene for Got It All quest.
            if (player:getCharVar("gotitallCS") == 5) then
                player:startEvent(526)
            end
        end,

        [2] = function (x) -- CS for Vanishing Act Quest
            if (player:getCharVar("vanishingactCS") == 3) then
                player:startEvent(44)
            end
        end,

        [5] = function (x) -- AH mission
            if (toauMission == xi.mission.id.toau.STIRRINGS_OF_WAR and player:getCharVar("AhtUrganStatus") == 1) then
                player:startEvent(3136, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            elseif
                player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS) == QUEST_COMPLETED and
                player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS) == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.COR and
                player:getMainLvl() >= xi.settings.AF3_QUEST_LEVEL
            then
                player:startEvent(797)
            end
        end,
    }
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onTransportEvent = function(player, transport)
    if (transport == 46 or transport == 47) then
        player:startEvent(200)
    elseif (transport == 58 or transport == 59) then
        player:startEvent(203)
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 44) then
        player:setCharVar("vanishingactCS", 4)
        player:setPos(-80, -6, 122, 5)
    elseif (csid == 200) then
        player:setPos(0, -2, 0, 0, 47)
    elseif (csid == 201) then
        player:setPos(-11, 2, -142, 192)
    elseif (csid == 203) then
        player:setPos(0, -2, 0, 0, 58)
    elseif (csid == 204) then
        player:setPos(11, 2, 142, 64)
    elseif (csid == 526) then
        player:setCharVar("gotitallCS", 6)
        player:setPos(60, 0, -71, 38)
    elseif (csid == 3136) then
        player:completeMission(xi.mission.log_id.TOAU, xi.mission.id.toau.STIRRINGS_OF_WAR)
        player:setCharVar("AhtUrganStatus", 0)
        player:addKeyItem(xi.ki.ALLIED_COUNCIL_SUMMONS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ALLIED_COUNCIL_SUMMONS)
        player:addMission(xi.mission.log_id.TOAU, xi.mission.id.toau.ALLIED_RUMBLINGS)
    elseif (csid == 797) then
        player:setCharVar("AgainstAllOdds", 1) -- Set For Corsair BCNM
        player:addQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS) -- Start of af 3 not completed yet
        player:addKeyItem(xi.ki.LIFE_FLOAT) -- BCNM KEY ITEM TO ENTER BCNM
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.LIFE_FLOAT)
        player:setCharVar("AgainstAllOddsTimer", getMidnight())
    end
end

return zone_object
