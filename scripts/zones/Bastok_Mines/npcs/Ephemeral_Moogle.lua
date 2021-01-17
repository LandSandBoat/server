-----------------------------------
-- Area: Bastok Mines
--  NPC: Ephemeral Moogle
-- Type: Crystal Strage NPC
-- !pos 118.870 2.020 4.290 234
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
