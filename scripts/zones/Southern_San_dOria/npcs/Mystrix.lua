-----------------------------------
-- Area: Windurst Woods
--  NPC: Arbitrix
-- Gobbie Mystery Box
-- !pos -215.5 0.0 -147.3
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
    OTHER_BAD_TRADE         = 4013,
    ITEM_CANNOT_BE_OBTAINED = 6426,
    LIL_BABY                = 6468
}

function onTrigger(player, npc)
    tpz.mystery.onTrigger(player, npc, events)
end

function onEventUpdate(player, csid, option)
    tpz.mystery.onEventUpdate(player, csid, option, events)
end

function onEventFinish(player, csid, option)
    tpz.mystery.onEventFinish(player, csid, options, events)
end