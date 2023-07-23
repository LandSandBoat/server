-----------------------------------
-- Area: Windurst Woods
--  NPC: Forine
-- Involved In Mission: Journey Abroad
-- !pos -52.677 -0.501 -26.299 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getNation() == xi.nation.SANDORIA then
        player:startEvent(446)
    else
        player:startEvent(445)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
