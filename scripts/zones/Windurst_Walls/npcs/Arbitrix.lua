-----------------------------------
-- Area: Windurst Walls
--  NPC: Arbitrix
-- Gobbie Mystery Box
-- !pos -215.5 0.0 -147.3
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
require("scripts/globals/settings")
require("scripts/globals/gobbiemysterybox")
-----------------------------------

local events =
{
    INTRO                   = 519,
    DEFAULT                 = 520,
    HOLDING_ITEM            = 521,
    TRADE                   = 522,
    BAD_TRADE               = 523,
    DAILY_COOLDOWN          = 524,
    HIT_MAX                 = 525,
    RESULT                  = 534,
    KEY_TRADE               = 536,
    NO_THANKS               = 537,
    FULL_INV                = 538,
    OTHER_BAD_TRADE         = 539
}

function onTrade(player,npc,trade)
    tpz.mystery.onTrade(player, npc, trade, events)
end

function onTrigger(player, npc)
    tpz.mystery.onTrigger(player, npc, events)
end

function onEventUpdate(player, csid, option)
    tpz.mystery.onEventUpdate(player, csid, option, events)
end

function onEventFinish(player, csid, option)
    tpz.mystery.onEventFinish(player, csid, options, events)
end