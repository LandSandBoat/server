-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Nenne
-- Starts and Finishes Quest: To Cure a Cough
-- !pos -114 -6 102 230
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local medicineWoman = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_MEDICINE_WOMAN)
    local toCureaCough = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TO_CURE_A_COUGH)

    if
        toCureaCough == QUEST_AVAILABLE and
        player:getCharVar("toCureaCough") == 0 and
        medicineWoman == QUEST_COMPLETED
    then
        player:startEvent(538)
    elseif player:hasKeyItem(xi.ki.COUGH_MEDICINE) then
        player:startEvent(647)
    else
        player:startEvent(584)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 538 then
        player:setCharVar("toCureaCough", 1)
    elseif csid == 647 then
        player:addTitle(xi.title.A_MOSS_KIND_PERSON)
        player:setCharVar("toCureaCough", 0)
        player:delKeyItem(xi.ki.COUGH_MEDICINE)
        player:addKeyItem(xi.ki.SCROLL_OF_TREASURE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.SCROLL_OF_TREASURE)
        player:addFame(xi.quest.fame_area.SANDORIA, 30)
        player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TO_CURE_A_COUGH)
    end
end

return entity
