-----------------------------------
--
-- Zone: Aht_Urhgan_Whitegate (50)
--
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1, 57, -1, -70, 62, 1, -65) -- Sets Mark for "Got It All" Quest cutscene.
    zone:registerRegion(2, -96, -7, 121, -64, -5, 137) -- Sets Mark for "Vanishing Act" Quest cutscene.
    zone:registerRegion(3, 14, -7, -65, 37, -2, -41) -- TOAU Mission 1 CS area
    zone:registerRegion(4, 75, -3, 25, 90, 1, 59)
    zone:registerRegion(5, 73, -7, -137, 95, -3, -115) -- entering Shaharat Teahouse
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        if (prevZone == tpz.zone.OPEN_SEA_ROUTE_TO_AL_ZAHBI) then
            cs = 201
        elseif (prevZone == tpz.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI) then
            cs = 204
        elseif (prevZone == tpz.zone.SILVER_SEA_ROUTE_TO_NASHMAU) then
            cs = 204
        else
            -- MOG HOUSE EXIT
            local position = math.random(1, 5) - 83
            player:setPos(-100, 0, position, 0)
        end
    end

    if (player:getCurrentMission(TOAU) == tpz.mission.id.toau.STIRRINGS_OF_WAR and player:getCharVar("AhtUrganStatus") == 0 and
            player:getCharVar("TOAUM38_STARTDAY") ~= VanadielDayOfTheYear() and player:needToZone() == false) then
        cs = 3220
    end

    return cs
end

function afterZoneIn(player)
    player:entityVisualPacket("1pb1")
end

function onRegionEnter(player, region)
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
        [3] = function (x) -- TOAU Mission 1
            if (player:getCurrentMission(TOAU)== tpz.mission.id.toau.LAND_OF_SACRED_SERPENTS) then
                player:startEvent(3000, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.A_MERCENARY_LIFE and player:needToZone() == false) then
                if (prevZone ~= tpz.zone.AHT_URHGAN_WHITEGATE) then
                    player:startEvent(3050, 3, 3, 3, 3, 3, 3, 3, 3, 0)
                end
            elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.FINDERS_KEEPERS) then
                player:startEvent(3093)
            elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.SOCIAL_GRACES) then
                player:startEvent(3095)
            elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.FOILED_AMBITION and player:getCharVar("TOAUM23_STARTDAY") ~= VanadielDayOfTheYear() and player:needToZone() == false) then
                player:startEvent(3097, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.PLAYING_THE_PART and player:getCharVar("TOAUM24_STARTDAY") ~= VanadielDayOfTheYear() and player:needToZone() == false) then
                player:startEvent(3110)
            elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.PATH_OF_BLOOD) then
                player:startEvent(3131, 1, 1, 1, 1, 1, 1, 1, 1)
            end
        end,
        [4] = function (x) -- AH mission
            if (player:getCurrentMission(TOAU)== tpz.mission.id.toau.KNIGHT_OF_GOLD and player:getCharVar("AhtUrganStatus") == 2) then
                player:startEvent(3024, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            elseif (player:getCurrentMission(TOAU)== tpz.mission.id.toau.BASTION_OF_KNOWLEDGE) then
                player:startEvent(3112)
            end
        end,
        [5] = function (x) -- AH mission
            if (player:getCurrentMission(TOAU)== tpz.mission.id.toau.KNIGHT_OF_GOLD and player:getCharVar("AhtUrganStatus") == 3) then
                player:startEvent(3026, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.WESTERLY_WINDS and player:getCharVar("AhtUrganStatus") == 0) then
                player:startEvent(3027, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.SWEETS_FOR_THE_SOUL) then
                player:startEvent(3092)
            elseif (player:getCurrentMission(TOAU) == tpz.mission.id.toau.STIRRINGS_OF_WAR and player:getCharVar("AhtUrganStatus") == 1) then
                player:startEvent(3136, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            elseif (player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS) == QUEST_COMPLETED and player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.AGAINST_ALL_ODDS) == QUEST_AVAILABLE and player:getMainJob() == tpz.job.COR and player:getMainLvl() >= AF3_QUEST_LEVEL) then
                player:startEvent(797)
            end
        end,
    }
end

function onRegionLeave(player, region)
end

function onTransportEvent(player, transport)
    if (transport == 46 or transport == 47) then
        player:startEvent(200)
    elseif (transport == 58 or transport == 59) then
        player:startEvent(203)
    end
end

function onEventUpdate(player, csid, option)
    if (csid == 3050 and option == 1) then
        if (player:getLocalVar("A_MERCENARY_LIFE") == 0) then
            player:setLocalVar("A_MERCENARY_LIFE", 1)
            player:updateEvent(1, 0, 0, 0, 0, 0, 0, 0)
        else
            player:updateEvent(3, 0, 0, 0, 0, 0, 0, 0)
        end
    elseif (csid == 3050 and option == 2) then
        if (player:getLocalVar("A_MERCENARY_LIFE") == 0) then
            player:setLocalVar("A_MERCENARY_LIFE", 1)
            player:updateEvent(2, 0, 0, 0, 0, 0, 0, 0)
        else
            player:updateEvent(3, 0, 0, 0, 0, 0, 0, 0)
        end
    end
end

function onEventFinish(player, csid, option)
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
    elseif (csid == 3000) then
        player:addKeyItem(tpz.ki.SUPPLIES_PACKAGE)
        player:completeMission(TOAU, tpz.mission.id.toau.LAND_OF_SACRED_SERPENTS)
        player:addMission(TOAU, tpz.mission.id.toau.IMMORTAL_SENTRIES)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SUPPLIES_PACKAGE)
    elseif (csid == 3024) then
        player:setCharVar("AhtUrganStatus", 3)
    elseif (csid == 3026) then
        player:setCharVar("AhtUrganStatus", 0)
        player:addKeyItem(tpz.ki.RAILLEFALS_LETTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.RAILLEFALS_LETTER)
        player:completeMission(TOAU, tpz.mission.id.toau.KNIGHT_OF_GOLD)
        player:addMission(TOAU, tpz.mission.id.toau.CONFESSIONS_OF_ROYALTY)
    elseif (csid == 3027) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2185)
        else
            player:setCharVar("AhtUrganStatus", 1)
            player:addKeyItem(tpz.ki.RAILLEFALS_NOTE)
            player:setTitle(tpz.title.AGENT_OF_THE_ALLIED_FORCES)
            player:addItem(2185, 1)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.RAILLEFALS_NOTE)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 2185)
        end
    elseif (csid == 3050) then
        player:completeMission(TOAU, tpz.mission.id.toau.A_MERCENARY_LIFE)
        player:addMission(TOAU, tpz.mission.id.toau.UNDERSEA_SCOUTING)
    elseif (csid == 3092) then
        player:completeMission(TOAU, tpz.mission.id.toau.SWEETS_FOR_THE_SOUL)
        player:addMission(TOAU, tpz.mission.id.toau.TEAHOUSE_TUMULT)
    elseif (csid == 3093) then
        player:completeMission(TOAU, tpz.mission.id.toau.FINDERS_KEEPERS)
        player:setTitle(tpz.title.KARABABAS_BODYGUARD)
        player:addMission(TOAU, tpz.mission.id.toau.SHIELD_OF_DIPLOMACY)
    elseif (csid == 3095) then
        player:completeMission(TOAU, tpz.mission.id.toau.SOCIAL_GRACES)
        player:needToZone(true)
        player:setCharVar("TOAUM23_STARTDAY", VanadielDayOfTheYear())
        player:addMission(TOAU, tpz.mission.id.toau.FOILED_AMBITION)
    elseif (csid == 3097) then
        player:completeMission(TOAU, tpz.mission.id.toau.FOILED_AMBITION)
        player:setTitle(tpz.title.KARABABAS_SECRET_AGENT)
        player:addItem(2187, 5)
        player:setCharVar("TOAUM23_STARTDAY", 0)
        player:needToZone(true)
        player:setCharVar("TOAUM24_STARTDAY", VanadielDayOfTheYear())
        player:addMission(TOAU, tpz.mission.id.toau.PLAYING_THE_PART)
    elseif (csid == 3110) then
        player:completeMission(TOAU, tpz.mission.id.toau.PLAYING_THE_PART)
        player:setCharVar("TOAUM24_STARTDAY", 0)
        player:addMission(TOAU, tpz.mission.id.toau.SEAL_OF_THE_SERPENT)
    elseif (csid == 3112) then
        player:completeMission(TOAU, tpz.mission.id.toau.BASTION_OF_KNOWLEDGE)
        player:setTitle(tpz.title.APHMAUS_MERCENARY)
        player:addMission(TOAU, tpz.mission.id.toau.PUPPET_IN_PERIL)
    elseif (csid == 3131) then
        player:completeMission(TOAU, tpz.mission.id.toau.PATH_OF_BLOOD)
        player:needToZone(true)
        player:setCharVar("TOAUM38_STARTDAY", VanadielDayOfTheYear())
        player:addMission(TOAU, tpz.mission.id.toau.STIRRINGS_OF_WAR)
    elseif (csid == 3220) then
        player:setCharVar("TOAUM38_STARTDAY", 0)
        player:setCharVar("AhtUrganStatus", 1)
    elseif (csid == 3136) then
        player:completeMission(TOAU, tpz.mission.id.toau.STIRRINGS_OF_WAR)
        player:setCharVar("AhtUrganStatus", 0)
        player:addKeyItem(tpz.ki.ALLIED_COUNCIL_SUMMONS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ALLIED_COUNCIL_SUMMONS)
        player:addMission(TOAU, tpz.mission.id.toau.ALLIED_RUMBLINGS)
    elseif (csid == 797) then
        player:setCharVar("AgainstAllOdds", 1) -- Set For Corsair BCNM
        player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.AGAINST_ALL_ODDS) -- Start of af 3 not completed yet
        player:addKeyItem(tpz.ki.LIFE_FLOAT) -- BCNM KEY ITEM TO ENTER BCNM
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LIFE_FLOAT)
    end
end
