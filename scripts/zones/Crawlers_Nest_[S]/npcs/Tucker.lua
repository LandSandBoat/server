-----------------------------------
-- Area: Crawlers' Nest [S]
--  NPC: Tucker
-----------------------------------
local ID = require("scripts/zones/Crawlers_Nest_[S]/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local aLittleKnowledge = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.A_LITTLE_KNOWLEDGE)
    local aLittleKnowledgeProgress = player:getCharVar("ALittleKnowledge")
    local sheetsofVellumProgress = player:getCharVar("SheetsofVellum")

    if
        aLittleKnowledge == QUEST_ACCEPTED and
        aLittleKnowledgeProgress == 1 and
        sheetsofVellumProgress > 0 and
        sheetsofVellumProgress < 4
    then
        if
            trade:hasItemQty(4365, 48) and
            trade:getGil() == 0 and
            trade:getItemCount() == 48
        then
            if sheetsofVellumProgress == 1 then
                player:startEvent(8)
            elseif sheetsofVellumProgress == 2 then
                player:startEvent(10)
            elseif sheetsofVellumProgress == 3 then
                player:startEvent(11)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local aLittleKnowledge = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.A_LITTLE_KNOWLEDGE)
    local aLittleKnowledgeProgress = player:getCharVar("ALittleKnowledge")
    local sheetsofVellumProgress = player:getCharVar("SheetsofVellum")

    if aLittleKnowledge == QUEST_ACCEPTED and aLittleKnowledgeProgress == 1 then
        if sheetsofVellumProgress == 1 then
            player:startEvent(7)
        elseif sheetsofVellumProgress == 2 or sheetsofVellumProgress == 3 then
            player:startEvent(9)
        elseif sheetsofVellumProgress == 4 then
            player:startEvent(12)
        else
            player:startEvent(6)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 6 then
        player:setCharVar("SheetsofVellum", 1)
    elseif csid == 8 then
        if player:getFreeSlotsCount() > 0 then
            player:tradeComplete()
            player:addItem(2550, 4)
            player:messageSpecial(ID.text.ITEM_OBTAINED + 9, 2550, 4)
            player:setCharVar("SheetsofVellum", 2)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2550)
        end
    elseif csid == 10 then
        if player:getFreeSlotsCount() > 0 then
            player:tradeComplete()
            player:addItem(2550, 4)
            player:messageSpecial(ID.text.ITEM_OBTAINED + 9, 2550, 4)
            player:setCharVar("SheetsofVellum", 3)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2550)
        end
    elseif csid == 11 then
        if player:getFreeSlotsCount() > 0 then
            player:tradeComplete()
            player:addItem(2550, 4)
            player:messageSpecial(ID.text.ITEM_OBTAINED + 9, 2550, 4)
            player:setCharVar("SheetsofVellum", 4)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2550)
        end
    end
end

return entity
