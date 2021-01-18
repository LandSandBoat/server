-----------------------------------
-- Area: Bastok Markets
--  NPC: Ephemeral Moogle
-- Type: Crystal Strage NPC
-- !pos -185.750 -2.000 -3.860 230
-----------------------------------
require("scripts/globals/ephemeral")
-----------------------------------
local entity = {}

local triggerEvent = 617
local tradeEvent = 618
local failEvent = 619

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
