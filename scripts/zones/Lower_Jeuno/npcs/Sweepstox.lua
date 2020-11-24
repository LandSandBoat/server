-----------------------------------
-- Area: Lower Jeuno
--  NPC: Sweepstox
-- Gobbie Mystery Box
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/settings")
require("scripts/globals/gobbiemysterybox")
-----------------------------------

local events =
{
    INTRO                   = 20055,
    DEFAULT                 = 20056,
    HOLDING_ITEM            = 20057,
    TRADE                   = 20058,
    BAD_TRADE               = 20059,
    DAILY_COOLDOWN          = 20060,
    HIT_MAX                 = 20061,
    RESULT                  = 20064,
    KEY_TRADE               = 20065,
    NO_THANKS               = 20066,
    FULL_INV                = 20067,
    OTHER_BAD_TRADE         = 20068
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