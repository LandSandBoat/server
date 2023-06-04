-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Miah Riyuh
-- !pos 5.323 -2 37.462 94
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local allegiance = player:getCampaignAllegiance()
    -- 0 = none, 1 = San d'Oria Iron Rams, 2 = Bastok Fighting Fourth, 3 = Windurst Cobras

    local theFightingFourth = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH)
    local snakeOnThePlains = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SNAKE_ON_THE_PLAINS)
    local steamedRams = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.STEAMED_RAMS)
    local greenLetter = player:hasKeyItem(xi.ki.GREEN_RECOMMENDATION_LETTER)

    if steamedRams == QUEST_ACCEPTED or theFightingFourth == QUEST_ACCEPTED then
        player:startEvent(122)
    elseif snakeOnThePlains == QUEST_AVAILABLE and greenLetter then
        player:startEvent(103)
    elseif
        snakeOnThePlains == QUEST_AVAILABLE and
        player:getCharVar("GREEN_R_LETTER_USED") == 1
    then
        player:startEvent(105)
    elseif
        snakeOnThePlains == QUEST_ACCEPTED and
        utils.mask.isFull(player:getCharVar("SEALED_DOORS"), 3)
    then
        player:startEvent(106)
    elseif
        snakeOnThePlains == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)
    then
        local puttyUsed = 0

        if utils.mask.getBit(player:getCharVar("SEALED_DOORS"), 0) then
            puttyUsed = puttyUsed + 1
        end

        if utils.mask.getBit(player:getCharVar("SEALED_DOORS"), 1) then
            puttyUsed = puttyUsed + 1
        end

        if utils.mask.getBit(player:getCharVar("SEALED_DOORS"), 2) then
            puttyUsed = puttyUsed + 1
        end

        player:startEvent(104, 0, 0, 0, 0, 0, 0, 0, puttyUsed)
    elseif snakeOnThePlains == QUEST_COMPLETED and allegiance == 3 then
        player:startEvent(107)
    else
        player:startEvent(121)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 103 and option == 0 then
        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SNAKE_ON_THE_PLAINS)
        player:addKeyItem(xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)
        player:setCharVar("GREEN_R_LETTER_USED", 1)
        player:delKeyItem(xi.ki.GREEN_RECOMMENDATION_LETTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)
    elseif csid == 103 and option == 1 then
        player:setCharVar("GREEN_R_LETTER_USED", 1)
        player:delKeyItem(xi.ki.GREEN_RECOMMENDATION_LETTER)
    elseif csid == 104 and option == 1 then
        player:delQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SNAKE_ON_THE_PLAINS)
        player:delKeyItem(xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)
        player:setCharVar("SEALED_DOORS", 0)
    elseif csid == 105 and option == 0 then
        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SNAKE_ON_THE_PLAINS)
        player:addKeyItem(xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)
        player:setCharVar("GREEN_R_LETTER_USED", 1)
        player:delKeyItem(xi.ki.GREEN_RECOMMENDATION_LETTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)
    elseif csid == 106 and option == 0 then
        -- Is first join, so add Sprinter's Shoes and bronze medal
        if player:getCharVar("Campaign_Nation") == 0 then
            if player:getFreeSlotsCount() >= 1 then
                player:setCampaignAllegiance(3)
                player:setCharVar("GREEN_R_LETTER_USED", 0)
                player:addTitle(xi.title.COBRA_UNIT_MERCENARY)
                player:addKeyItem(xi.ki.BRONZE_RIBBON_OF_SERVICE)
                player:addItem(15754)
                player:completeQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SNAKE_ON_THE_PLAINS)
                player:setCharVar("SEALED_DOORS", 0)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BRONZE_RIBBON_OF_SERVICE)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 15754)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 15754)
            end
        else
            player:setCampaignAllegiance(3)
            player:setCharVar("GREEN_R_LETTER_USED", 0)
            player:addTitle(xi.title.COBRA_UNIT_MERCENARY)
            player:completeQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SNAKE_ON_THE_PLAINS)
            player:setCharVar("SEALED_DOORS", 0)
        end
    end
end

return entity
