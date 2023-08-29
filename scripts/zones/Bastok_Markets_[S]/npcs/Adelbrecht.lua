-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Adelbrecht
-- Starts Quests: The Fighting Fourth
-- Involved in Missions: Back to the Beginning
-- CS IDs:
-- 139 = 139 = Greetings, civilian. The Seventh Cohors of the Republican Legion's Fourth Division is currently recruiting new troops.
-- 140 = 140 = I thought you didn't have any questions...throw in the towel yes/no
-- 141 = 141 = Mid quest, after first npc in N Gust
-- 142 = 142 = Mid quest, after second npc in N Gust
-- 143 = 143 = Complete quest, get bronze ribbon
-- 162 = 162 = After cs143, before heading over to talk to next person
-- 359 = 359 = A CS where player is looking for Lilisette, with flashback of Lilisette asking about player
-- 361 = 361 = After asking in CS 359
-- Todo: medal loss from nation switching. Since there is no rank-up yet, this isn't so important for now.
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local allegiance = player:getCampaignAllegiance()
    -- 0 = none, 1 = San d'Oria Iron Rams, 2 = Bastok Fighting Fourth, 3 = Windurst Cobras

    local theFightingFourth = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH)

    if
        theFightingFourth == QUEST_AVAILABLE and
        player:hasKeyItem(xi.ki.BLUE_RECOMMENDATION_LETTER)
    then
        player:startEvent(139)
    elseif
        theFightingFourth == QUEST_AVAILABLE and
        player:getCharVar("BLUE_R_LETTER_USED") == 1
    then
        player:startEvent(139)
    elseif
        theFightingFourth == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.BATTLE_RATIONS)
    then
        player:startEvent(140)
    elseif
        theFightingFourth == QUEST_ACCEPTED and
        player:getCharVar("THE_FIGHTING_FOURTH") == 1
    then
        player:startEvent(141)
    elseif
        theFightingFourth == QUEST_ACCEPTED and
        player:getCharVar("THE_FIGHTING_FOURTH") == 2
    then
        player:startEvent(142)
    elseif
        theFightingFourth == QUEST_ACCEPTED and
        player:getCharVar("THE_FIGHTING_FOURTH") == 3
    then
        player:startEvent(143)
    elseif
        theFightingFourth == QUEST_COMPLETED and
        allegiance == 1
    then
        player:startEvent(162)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 139 and option == 1 then
        player:addKeyItem(xi.ki.BATTLE_RATIONS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BATTLE_RATIONS)
        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH)
        player:setCharVar("BLUE_R_LETTER_USED", 1)
        player:delKeyItem(xi.ki.BLUE_RECOMMENDATION_LETTER)
    elseif csid == 140 and option == 1 then
        player:delKeyItem(xi.ki.BATTLE_RATIONS)
        player:delQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH)
    elseif csid == 141 or csid == 142 and option == 1 then
        player:delQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH)
    elseif csid == 143 then
        -- Is first join, so add Sprinter's Shoes and bronze medal
        if player:getCharVar("Campaign_Nation") == 0 then
            if player:getFreeSlotsCount() >= 1 then
                player:setCampaignAllegiance(2)
                player:setCharVar("BLUE_R_LETTER_USED", 0)
                player:addTitle(xi.title.FOURTH_DIVISION_SOLDIER)
                player:addKeyItem(xi.ki.BRONZE_RIBBON_OF_SERVICE)
                player:addItem(15754)
                player:completeQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BRONZE_RIBBON_OF_SERVICE)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 15754)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 15754)
            end
        else
            player:setCampaignAllegiance(2)
            player:setCharVar("BLUE_R_LETTER_USED", 0)
            player:addTitle(xi.title.FOURTH_DIVISION_SOLDIER)
            player:completeQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH)
        end
    end
end

return entity
