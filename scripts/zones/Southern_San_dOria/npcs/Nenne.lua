-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Nenne
-- Starts and Finishes Quest: To Cure a Cough
-- !pos -114 -6 102 230
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    medicineWoman = player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.THE_MEDICINE_WOMAN)
    toCureaCough = player:getQuestStatus(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.TO_CURE_A_COUGH)

    if (toCureaCough == QUEST_AVAILABLE and player:getCharVar("toCureaCough") == 0 and medicineWoman == QUEST_COMPLETED) then
        player:startEvent(538)
    elseif (player:hasKeyItem(tpz.ki.COUGH_MEDICINE) == true) then
        player:startEvent(647)
    else
        player:startEvent(584)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 538) then
        player:setCharVar("toCureaCough", 1)
    elseif (csid == 647) then
        player:addTitle(tpz.title.A_MOSS_KIND_PERSON)
        player:setCharVar("toCureaCough", 0)
        player:delKeyItem(tpz.ki.COUGH_MEDICINE)
        player:addKeyItem(tpz.ki.SCROLL_OF_TREASURE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SCROLL_OF_TREASURE)
        player:addFame(SANDORIA, 30)
        player:completeQuest(tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.TO_CURE_A_COUGH)
    end

end

return entity
