-----------------------------------
-- Area: Winurst Waters
--  NPC: Ephemeral Moogle
-- Type: Crystal Strage NPC
-- !pos -117.250 -2.000 60.890 238
-----------------------------------
require("scripts/globals/ephemeral")
-----------------------------------
local entity = {}

local triggerEvent = 1098
local tradeEvent = 1099
local failEvent = 1100

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
