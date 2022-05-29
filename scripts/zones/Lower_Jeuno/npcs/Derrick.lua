-----------------------------------
-- Area: Lower Jeuno
--  NPC: Derrick
-- Involved in Quests and finish : Save the Clock Tower
-- !pos -32 -1 -7 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local TotalNPC = player:getCharVar("saveTheClockTowerNPCz1") + player:getCharVar("saveTheClockTowerNPCz2")

    if
        TotalNPC == 1023 and
        trade:hasItemQty(555, 1) == true and
        trade:getItemCount() == 1
    then
        player:startEvent(231) -- Ending quest "save the clock tower"
    end
end

entity.onTrigger = function(player, npc)
    local airshipKI         = player:hasKeyItem(xi.ki.AIRSHIP_PASS)
    local saveTheClockTower = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_THE_CLOCK_TOWER)
    local npcNumber         = player:getCharVar("saveTheClockTowerVar") -- Quest step & number of npc

    if
        airshipKI == false and
        saveTheClockTower == QUEST_ACCEPTED and
        npcNumber >= 1 and
        npcNumber <= 11
    then
        player:startEvent(230, 4, 10) -- airship + petition help/restart

    elseif
        airshipKI == true and
        saveTheClockTower == QUEST_ACCEPTED and
        npcNumber >= 1 and
        npcNumber <= 11
    then
        player:startEvent(230, 6, 10) -- petition help/restart

    elseif
        airshipKI == false and
        saveTheClockTower == QUEST_ACCEPTED and
        npcNumber == 0
    then
        player:startEvent(230, 8, 10) -- airship + petition

    elseif
        airshipKI == true and
        saveTheClockTower == QUEST_ACCEPTED and
        npcNumber == 0
    then
        player:startEvent(230, 10, 10) -- petition

    elseif airshipKI == false then
        player:startEvent(230, 12) -- airship

    else
        player:startEvent(230, 14) -- rien
    end
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 230 and option == 10 then
        if player:delGil(500000) then
            player:addKeyItem(xi.ki.AIRSHIP_PASS)
            player:updateEvent(0, 1)
        else
            player:updateEvent(0, 0)
        end
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 230 and option == 10 then
        if player:hasKeyItem(xi.ki.AIRSHIP_PASS) == true then
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.AIRSHIP_PASS)
        end
    elseif csid == 230 and option == 20 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 555)
        else
            player:addItem(555)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 555)
            player:setCharVar("saveTheClockTowerVar", 1)
            player:setCharVar("saveTheClockTowerNPCz1", 0)
            player:setCharVar("saveTheClockTowerNPCz2", 0)
        end
    elseif csid == 230 and option == 30 then
        if player:hasItem(555) == true then
            player:messageSpecial(ID.text.ITEM_OBTAINED, 555)
            player:setCharVar("saveTheClockTowerVar", 1)
            player:setCharVar("saveTheClockTowerNPCz1", 0)
            player:setCharVar("saveTheClockTowerNPCz2", 0)
        else
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 555)
            else
                player:addItem(555)
                player:messageSpecial(ID.text.ITEM_OBTAINED, 555)
                player:setCharVar("saveTheClockTowerVar", 1)
                player:setCharVar("saveTheClockTowerNPCz1", 0)
                player:setCharVar("saveTheClockTowerNPCz2", 0)
            end
        end
    elseif csid == 231 then
        player:setCharVar("saveTheClockTowerVar", 0)
        player:setCharVar("saveTheClockTowerNPCz1", 0)
        player:setCharVar("saveTheClockTowerNPCz2", 0)
        player:addTitle(xi.title.CLOCK_TOWER_PRESERVATIONIST)
        player:addFame(xi.quest.fame_area.JEUNO, 30)
        player:tradeComplete()
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_THE_CLOCK_TOWER)
    end
end

return entity
