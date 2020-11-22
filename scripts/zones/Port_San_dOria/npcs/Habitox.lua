-----------------------------------
-- Area: Port San d'Oria
--  NPC: Habitox
-- Gobbie Mystery Box
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/gobbiemysterybox")
-----------------------------------

local events =
{
    INTRO                   = 797,
    DEFAULT                 = 798,
    HOLDING_ITEM            = 799,
    TRADE                   = 800,
    BAD_TRADE               = 801,
    DAILY_COOLDOWN          = 802,
    HIT_MAX                 = 803,
    RESULT                  = 811,
    KEY_TRADE               = 812,
    NO_THANKS               = 813,
    FULL_INV                = 814,
    OTHER_BAD_TRADE         = 815
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