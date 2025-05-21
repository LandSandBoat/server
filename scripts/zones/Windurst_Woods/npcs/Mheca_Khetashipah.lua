-----------------------------------
-- Area: Windurst Woods
--  NPC: Mheca Khetashipah
-- !pos 66.881 -6.249 185.752 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local starStatus = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.MIHGOS_AMIGO)

    if starStatus == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(83)
    else
        -- Possibly not their default dialogue. Event #79 witnessed in capture. Leaving for now until
        -- verified.
        player:startEvent(426)
    end
end

return entity
