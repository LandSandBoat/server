-----------------------------------
-- Area: Windurst Woods
--  NPC: Gottah Maporushanoh
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local amazinScorpio = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_AMAZIN_SCORPIO)

    if amazinScorpio == QUEST_COMPLETED then
        player:startEvent(486)
    elseif amazinScorpio == QUEST_ACCEPTED then
        player:startEvent(483)
    else
        player:startEvent(420)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
