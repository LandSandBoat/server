-----------------------------------
-- Area: Port Bastok
--  NPC: Ensetsu
-- Involved in Quest: 20 in Pirate Years, I'll Take the Big Box
-- !pos 33 -6 67 236
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local ayameAndKaede = player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE)

    if
        ayameAndKaede == xi.questStatus.QUEST_COMPLETED and
        player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS) == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(247)
    elseif player:getCharVar('twentyInPirateYearsCS') == 2 then
        player:startEvent(262)
    elseif player:getCharVar('twentyInPirateYearsCS') == 4 then
        player:startEvent(263)
    elseif
        player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('illTakeTheBigBoxCS') == 0
    then
        player:startEvent(264)
    elseif player:getCharVar('illTakeTheBigBoxCS') == 1 then
        player:startEvent(265)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 262 then
        player:setCharVar('twentyInPirateYearsCS', 3)
    elseif csid == 264 then
        player:setCharVar('illTakeTheBigBoxCS', 1)
    end
end

return entity
