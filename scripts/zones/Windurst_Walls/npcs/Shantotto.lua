-----------------------------------
-- Area: Windurst Walls (239)
--  NPC: Shantotto
-- !pos 122 -2 112 239
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CLASS_REUNION) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('ClassReunionProgress') == 3
    then
        player:startEvent(409) -- she mentions that Sunny-Pabonny left for San d'Oria
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 409 then
        player:setCharVar('ClassReunionProgress', 4)
    end
end

return entity
