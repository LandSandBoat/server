----------------------------------
-- Area: Crawlers' Nest [S]
--  NPC: Tucker
-----------------------------------
local ID = require("scripts/zones/Crawlers_Nest_[S]/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)

    local ALittleKnowledge = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.A_LITTLE_KNOWLEDGE)
    local ALittleKnowledgeProgress = player:getCharVar("ALittleKnowledge")
    local SheetsofVellumProgress = player:getCharVar("SheetsofVellum")

    if (ALittleKnowledge == QUEST_ACCEPTED and ALittleKnowledgeProgress == 1 and SheetsofVellumProgress > 0 and SheetsofVellumProgress < 4) then
        if (trade:hasItemQty(4365, 48) and trade:getGil() == 0 and trade:getItemCount() == 48) then
            if (SheetsofVellumProgress == 1) then
                player:startEvent(8)
            elseif (SheetsofVellumProgress == 2) then
                player:startEvent(10)
            elseif (SheetsofVellumProgress == 3) then
                player:startEvent(11)
            end
        end
    end

end

function onTrigger(player, npc)

    local ALittleKnowledge = player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.A_LITTLE_KNOWLEDGE)
    local ALittleKnowledgeProgress = player:getCharVar("ALittleKnowledge")
    local SheetsofVellumProgress = player:getCharVar("SheetsofVellum")

    if (ALittleKnowledge == QUEST_ACCEPTED and ALittleKnowledgeProgress == 1) then
        if (SheetsofVellumProgress == 1) then
            player:startEvent(7)
        elseif (SheetsofVellumProgress == 2 or SheetsofVellumProgress == 3) then
            player:startEvent(9)
        elseif (SheetsofVellumProgress == 4) then
            player:startEvent(12)
        else
            player:startEvent(6)
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 6) then
        player:setCharVar("SheetsofVellum", 1)
    elseif (csid == 8) then
        if (player:getFreeSlotsCount() > 0) then
            player:tradeComplete()
            player:addItem(2550, 4)
            player:messageSpecial(ID.text.ITEM_OBTAINED + 9, 2550, 4)
            player:setCharVar("SheetsofVellum", 2)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2550)
        end
    elseif (csid == 10) then
        if (player:getFreeSlotsCount() > 0) then
            player:tradeComplete()
            player:addItem(2550, 4)
            player:messageSpecial(ID.text.ITEM_OBTAINED + 9, 2550, 4)
            player:setCharVar("SheetsofVellum", 3)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2550)
        end
    elseif (csid == 11) then
        if (player:getFreeSlotsCount() > 0) then
            player:tradeComplete()
            player:addItem(2550, 4)
            player:messageSpecial(ID.text.ITEM_OBTAINED + 9, 2550, 4)
            player:setCharVar("SheetsofVellum", 4)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2550)
        end
    end

end
