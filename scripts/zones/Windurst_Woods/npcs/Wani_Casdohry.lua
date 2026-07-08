-----------------------------------
-- Area: Windurst Woods
--  NPC: Wani Casdohry
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local twinstoneBonding = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TWINSTONE_BONDING)
    local mihgosAmigo = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.MIHGOS_AMIGO)

    if twinstoneBonding == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(492, 0, 13360)
    elseif twinstoneBonding == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(489, 0, 13360)
    elseif mihgosAmigo == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(86, 0, 498)
    else
        player:startEvent(425)
    end
end

return entity
