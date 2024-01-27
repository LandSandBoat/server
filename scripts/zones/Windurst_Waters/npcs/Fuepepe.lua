-----------------------------------
-- Area: Windurst Waters
--  NPC: Fuepepe
-- Involved in Quest: Class Reunion
-- !pos 161 -2 161 238
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local classReunion = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CLASS_REUNION)

    -- CLASS REUNION
    if
        classReunion == QUEST_ACCEPTED and
        player:getCharVar('ClassReunionProgress') >= 3 and
        player:getCharVar('ClassReunion_TalkedToFupepe') ~= 1
    then
        player:startEvent(817) -- he tells you about Uran-Mafran
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 817 then
        player:setCharVar('ClassReunion_TalkedToFupepe', 1)
    end
end

return entity
