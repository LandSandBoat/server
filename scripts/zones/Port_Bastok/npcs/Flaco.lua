-----------------------------------
-- Area: Port Bastok
--  NPC: Flaco
-- Fame Checker
-- !zone 236
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(210 + player:getFameLevel(xi.fameArea.BASTOK))
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
