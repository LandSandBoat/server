-----------------------------------
-- Area: Bastok Markets
--  NPC: Ephemeral Moogle
-- Type: Crystal Strage NPC
-- !pos -185.750 -2.000 -3.860 230
-----------------------------------
require("scripts/globals/ephemeral")
-----------------------------------

local triggerEvent = 617
local tradeEvent = 618
local failEvent = 619

function onTrade(player, npc, trade)
    tpz.ephemeral.onTrade(player, trade, tradeEvent, failEvent)
end

function onTrigger(player, npc)
    tpz.ephemeral.onTrigger(player, triggerEvent)
end

function onEventUpdate(player, csid, option)
    tpz.ephemeral.onEventUpdate(player)
end

function onEventFinish(player, csid, option)
    tpz.ephemeral.onEventFinish(player, option, csid == tradeEvent)
end
