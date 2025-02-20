-----------------------------------
-- Area: Windurst Waters
--  NPC: Fuepepe
-- Involved in Quest: Class Reunion
-- !pos 161 -2 161 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local classReunion = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CLASS_REUNION)

    -- CLASS REUNION
    if
        classReunion == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('ClassReunionProgress') >= 3 and
        player:getCharVar('ClassReunion_TalkedToFupepe') ~= 1
    then
        player:startEvent(817) -- he tells you about Uran-Mafran
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 817 then
        player:setCharVar('ClassReunion_TalkedToFupepe', 1)
    end
end

return entity
