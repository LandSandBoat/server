-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Mainchelite
-- !pos -16 1 -30 80
-- CS IDs:
-- 5 = Generic Greeting for Iron Ram members
-- 6 = Mid Initiation of other nation
-- 7 = Ask player to Join Iron Rams
-- 8 = Ask if changed mind about joining Iron rams (after player has declined)
-- 9 = Mid Initiation of other nation
-- 10 = Player works for another nation, offer to switch +give quest
-- 11 = Player works for another nation, offer to switch +give quest
-- 12 = Complete investigation
-- 13 = "How fares the search, <player>?"
-- 14 = "How fares the search, <player>?"
-- 15 = No Red Recommendation Letter and has no nation affiliation
-- Todo: medal loss from nation switching. Since there is no rank-up yet, this isn't so important for now.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/missions")
local ID = require("scripts/zones/Southern_San_dOria_[S]/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local Allegiance = player:getCampaignAllegiance()
    -- 0 = none, 1 = San d'Oria Iron Rams, 2 = Bastok Fighting Fourth, 3 = Windurst Cobras

    local TheFightingFourth = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.THE_FIGHTING_FOURTH)
    local SnakeOnThePlains = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.SNAKE_ON_THE_PLAINS)
    local SteamedRams = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.STEAMED_RAMS)
    local RedLetter = player:hasKeyItem(tpz.ki.RED_RECOMMENDATION_LETTER)
    local CharredPropeller = player:hasKeyItem(tpz.ki.CHARRED_PROPELLER)
    local OxidizedPlate = player:hasKeyItem(tpz.ki.OXIDIZED_PLATE)
    local ShatteredLumber = player:hasKeyItem(tpz.ki.PIECE_OF_SHATTERED_LUMBER)

    if (TheFightingFourth == QUEST_ACCEPTED or SnakeOnThePlains == QUEST_ACCEPTED) then
        player:startEvent(9)
    elseif (SteamedRams == QUEST_AVAILABLE and RedLetter == true) then
        player:startEvent(7)
    elseif (SteamedRams == QUEST_AVAILABLE and player:getCharVar("RED_R_LETTER_USED") == 1) then
        player:startEvent(8)
    elseif (SteamedRams == QUEST_ACCEPTED and CharredPropeller == true and OxidizedPlate == true and ShatteredLumber == true) then
        player:startEvent(12)
    elseif (SteamedRams == QUEST_ACCEPTED) then
        player:startEvent(13)
    elseif (SteamedRams == QUEST_COMPLETED and Allegiance == 1) then
        player:startEvent(5)
    else
        player:startEvent(15)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 7 and option == 0) then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.STEAMED_RAMS)
        player:setCharVar("RED_R_LETTER_USED", 1)
        player:delKeyItem(tpz.ki.RED_RECOMMENDATION_LETTER)
    elseif (csid == 7 and option == 1) then
        player:setCharVar("RED_R_LETTER_USED", 1)
        player:delKeyItem(tpz.ki.RED_RECOMMENDATION_LETTER)
    elseif (csid == 8 and option == 0) then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.STEAMED_RAMS)
    elseif (csid == 10 and option == 0) then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.STEAMED_RAMS)
    elseif (csid == 11 and option == 0) then
        player:addQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.STEAMED_RAMS)
    elseif (csid == 12 and option == 0) then
        -- Is first join, so add Sprinter's Shoes and bronze medal
        if (player:getCharVar("Campaign_Nation") == 0) then
            if (player:getFreeSlotsCount() >= 1) then
                player:setCampaignAllegiance(1)
                player:setCharVar("RED_R_LETTER_USED", 0)
                player:addTitle(tpz.title.KNIGHT_OF_THE_IRON_RAM)
                player:addKeyItem(tpz.ki.BRONZE_RIBBON_OF_SERVICE)
                player:addItem(15754)
                player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.STEAMED_RAMS)
                player:delKeyItem(tpz.ki.CHARRED_PROPELLER)
                player:delKeyItem(tpz.ki.OXIDIZED_PLATE)
                player:delKeyItem(tpz.ki.PIECE_OF_SHATTERED_LUMBER)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BRONZE_RIBBON_OF_SERVICE)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 15754)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 15754)
            end
        else
            player:setCampaignAllegiance(1)
            player:setCharVar("RED_R_LETTER_USED", 0)
            player:addTitle(tpz.title.KNIGHT_OF_THE_IRON_RAM)
            player:completeQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.STEAMED_RAMS)
            player:delKeyItem(tpz.ki.CHARRED_PROPELLER)
            player:delKeyItem(tpz.ki.OXIDIZED_PLATE)
            player:delKeyItem(tpz.ki.PIECE_OF_SHATTERED_LUMBER)
        end
    elseif (csid == 13 and option == 1) then
        player:delQuest(CRYSTAL_WAR, tpz.quest.id.crystalWar.STEAMED_RAMS)
    end
end
