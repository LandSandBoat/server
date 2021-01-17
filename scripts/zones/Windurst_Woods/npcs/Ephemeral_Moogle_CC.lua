-----------------------------------
-- Area: Winurst Wood
--  NPC: Ephemeral Moogle
-- Type: Crystal Strage NPC
-- !pos -10.500 -5.250 -143.400 241 - Boneworker's Guild
-- !pos -34.840 -1.250 -114.490 241 - Weaver's Guild
-----------------------------------
require("scripts/globals/ephemeral")
-----------------------------------

local triggerEvent = 896
local tradeEvent = 898
local failEvent = 900

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
