-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ephemeral Moogle
-- Type: Crystal Strage NPC
-- !pos -185.750 -2.000 -3.860 230
-----------------------------------
local entity = {}

local triggerEvent = 3549
local tradeEvent = 3550
local failEvent = 3551

entity.onTrade = function(player, npc, trade)
    xi.ephemeral.onTrade(player, trade, tradeEvent, failEvent)
end

entity.onTrigger = function(player, npc)
    xi.ephemeral.onTrigger(player, triggerEvent)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.ephemeral.onEventUpdate(player)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.ephemeral.onEventFinish(player, option, csid == tradeEvent)
end

return entity
