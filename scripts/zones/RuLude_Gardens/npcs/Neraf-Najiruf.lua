-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Neraf-Najiruf
-- Involved in Quests: Save my Sister
-- !pos -36 2 60 243
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    saveMySister = player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.SAVE_MY_SISTER)

    if (saveMySister == QUEST_AVAILABLE and player:getCharVar("saveMySisterVar") == 3) then
        player:startEvent(98) -- Real start of this quest (with addquest)
    elseif (saveMySister == QUEST_ACCEPTED) then
        player:startEvent(99) -- During quest
    elseif (saveMySister == QUEST_COMPLETED and player:hasKeyItem(tpz.ki.DUCAL_GUARDS_LANTERN) == true) then
        player:startEvent(97) -- last CS (after talk with baudin)
    else
        player:startEvent(156) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 98) then
        player:addQuest(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.SAVE_MY_SISTER)
        player:setCharVar("saveMySisterVar", 0)
        player:addKeyItem(tpz.ki.DUCAL_GUARDS_LANTERN)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DUCAL_GUARDS_LANTERN)
    elseif (csid == 97) then
        player:delKeyItem(tpz.ki.DUCAL_GUARDS_LANTERN)
        player:setCharVar("saveMySisterFireLantern", 0)
    end
end

return entity
