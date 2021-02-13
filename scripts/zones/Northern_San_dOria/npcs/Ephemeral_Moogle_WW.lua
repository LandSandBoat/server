-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Ephemeral Moogle
-- Type: Crystal Strage NPC
-- !pos -176.090 12.000 268.910 231 - Carpenter's Guild
-- !pos -186.440 12.000 140.310 231 - Blacksmith's Guild
-----------------------------------
require("scripts/globals/ephemeral")
-----------------------------------
local entity = {}

local triggerEvent = 913
local tradeEvent = 915
local failEvent = 917

entity.onTrade = function(player, npc, trade)
    tpz.ephemeral.onTrade(player, trade, tradeEvent, failEvent)
end

entity.onTrigger = function(player, npc)
    tpz.ephemeral.onTrigger(player, triggerEvent)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.ephemeral.onEventUpdate(player)
end

entity.onEventFinish = function(player, csid, option)
    tpz.ephemeral.onEventFinish(player, option, csid == tradeEvent)
end

return entity
