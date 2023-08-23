-----------------------------------
-- Area: Windurst Woods
--  NPC: Wani Casdohry
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local twinstoneBonding = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TWINSTONE_BONDING)
    local mihgosAmigo = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MIHGO_S_AMIGO)

    if twinstoneBonding == QUEST_COMPLETED then
        player:startEvent(492, 0, 13360)
    elseif twinstoneBonding == QUEST_ACCEPTED then
        player:startEvent(489, 0, 13360)
    elseif mihgosAmigo == QUEST_ACCEPTED then
        player:startEvent(86, 0, 498)
    else
        player:startEvent(425)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
