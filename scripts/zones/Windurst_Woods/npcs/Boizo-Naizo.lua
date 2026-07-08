-----------------------------------
-- Area: Windurst Woods
--  NPC: Boizo-Naizo
-- Involved in Quest: Riding on the Clouds
-- !pos -9.581 -3.75 -26.062 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local allNewC2000 = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_ALL_NEW_C_2000)
    local greetingCardian = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.A_GREETING_CARDIAN)

    if allNewC2000 == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(290)
    elseif greetingCardian == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(307)
    else
        player:startEvent(275)
    end
end

return entity
