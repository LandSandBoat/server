-----------------------------------
-- Area: Kazham
--  NPC: Rauteinot
-- Starts and Finishes Quest: Missionary Man
-- !pos -42 -10 -89 250
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Kazham/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar("MissionaryManVar") == 1 and
        trade:hasItemQty(1146, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(139) -- Trading elshimo marble
    end
end

entity.onTrigger = function(player, npc)
    local missionaryMan = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.MISSIONARY_MAN)
    local missionaryManVar = player:getCharVar("MissionaryManVar")

    if
        missionaryMan == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.WINDURST) >= 3
    then
        player:startEvent(137, 0, 1146) -- Start quest "Missionary Man"
    elseif missionaryMan == QUEST_ACCEPTED and missionaryManVar == 1 then
        player:startEvent(138, 0, 1146) -- During quest (before trade marble) "Missionary Man"
    elseif
        missionaryMan == QUEST_ACCEPTED and
        (missionaryManVar == 2 or missionaryManVar == 3)
    then
        player:startEvent(140) -- During quest (after trade marble) "Missionary Man"
    elseif missionaryMan == QUEST_ACCEPTED and missionaryManVar == 4 then
        player:startEvent(141) -- Finish quest "Missionary Man"
    elseif missionaryMan == QUEST_COMPLETED then
        player:startEvent(142) -- New standard dialog
    else
        player:startEvent(136) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 137 and option == 1 then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.MISSIONARY_MAN)
        player:setCharVar("MissionaryManVar", 1)
    elseif csid == 139 then
        player:setCharVar("MissionaryManVar", 2)
        player:addKeyItem(xi.ki.RAUTEINOTS_PARCEL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.RAUTEINOTS_PARCEL)
        player:tradeComplete()
    elseif csid == 141 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4728)
        else
            player:setCharVar("MissionaryManVar", 0)
            player:delKeyItem(xi.ki.SUBLIME_STATUE_OF_THE_GODDESS)
            player:addItem(4728)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4728)
            player:addFame(xi.quest.fame_area.WINDURST, 30)
            player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.MISSIONARY_MAN)
        end
    end
end

return entity
