-----------------------------------
-- Area: Port Bastok
--  NPC: Ensetsu
-- Involved in Quest: 20 in Pirate Years
-- !pos 32 -7 69 236
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
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 262 then
        player:setCharVar('twentyInPirateYearsCS', 3)
    end
end

return entity
