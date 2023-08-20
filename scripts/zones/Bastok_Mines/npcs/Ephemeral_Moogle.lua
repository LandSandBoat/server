-----------------------------------
-- Area: Bastok Mines
--  NPC: Ephemeral Moogle
-- Type: Crystal Strage NPC
-- !pos 118.870 2.020 4.290 234
-----------------------------------
local entity = {}

local triggerEvent = 617
local tradeEvent   = 618
local failEvent    = 619

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
