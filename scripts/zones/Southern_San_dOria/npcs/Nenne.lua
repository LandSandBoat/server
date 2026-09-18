-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Nenne
-- Starts and Finishes Quest: To Cure a Cough
-- !pos -114 -6 102 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local medicineWoman = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_MEDICINE_WOMAN)
    local toCureaCough = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.TO_CURE_A_COUGH)

    if
        toCureaCough == xi.questStatus.QUEST_AVAILABLE and
        player:getCharVar('toCureaCough') == 0 and
        medicineWoman == xi.questStatus.QUEST_COMPLETED
    then
        player:startEvent(538)
    elseif player:hasKeyItem(xi.keyItem.COUGH_MEDICINE) then
        player:startEvent(647)
    else
        player:startEvent(584)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 538 then
        player:setCharVar('toCureaCough', 1)
    elseif csid == 647 then
        player:addTitle(xi.title.A_MOSS_KIND_PERSON)
        player:setCharVar('toCureaCough', 0)
        player:delKeyItem(xi.keyItem.COUGH_MEDICINE)
        npcUtil.giveKeyItem(player, xi.keyItem.SCROLL_OF_TREASURE)
        player:addFame(xi.fameArea.SANDORIA, 30)
        player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.TO_CURE_A_COUGH)
    end
end

return entity
