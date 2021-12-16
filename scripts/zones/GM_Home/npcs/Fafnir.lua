-----------------------------------
-- Area: GM Home
--  NPC: Fafnir
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:PrintToPlayer("Hello there!", 0, "Fafnir")
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
