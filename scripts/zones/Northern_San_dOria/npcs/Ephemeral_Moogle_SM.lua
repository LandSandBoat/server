-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Ephemeral Moogle
-- Type: Crystal Strage NPC
-- !pos -176.090 12.000 268.910 231 - Carpenter's Guild
-- !pos -186.440 12.000 140.310 231 - Blacksmith's Guild
-----------------------------------
local entity = {}

local triggerEvent = 914
local tradeEvent = 916
local failEvent = 917

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
