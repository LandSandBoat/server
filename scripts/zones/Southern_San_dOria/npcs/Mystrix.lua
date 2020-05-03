-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Mystrix
-- Gobbie Mystery Box
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/gobbiemysterybox")
-----------------------------------

local events =
{
    INTRO                   = 4000,
    DEFAULT                 = 4001,
    HOLDING_ITEM            = 4002,
    TRADE                   = 4003,
    BAD_TRADE               = 4004,
    DAILY_COOLDOWN          = 4005,
    HIT_MAX                 = 4006,
    RESULT                  = 4009,
    KEY_TRADE               = 4010,
    NO_THANKS               = 4011,
    FULL_INV                = 4012,
    OTHER_BAD_TRADE         = 4013
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