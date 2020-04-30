-----------------------------------
-- Area: Windurst Woods
--  NPC: Arbitrix
-- Gobbie Mystery Box
-- !pos -215.5 0.0 -147.3
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/settings")
require("scripts/globals/gobbiemysterybox")
-----------------------------------

local events =
{
    INTRO                   = 979,
    DEFAULT                 = 980,
    HOLDING_ITEM            = 981,
    TRADE                   = 982,
    BAD_TRADE               = 983,
    DAILY_COOLDOWN          = 984,
    HIT_MAX                 = 985,
    RESULT                  = 988,
    KEY_TRADE               = 989,
    NO_THANKS               = 990,
    FULL_INV                = 991,
    OTHER_BAD_TRADE         = 992,
    ITEM_CANNOT_BE_OBTAINED = 219,
    LIL_BABY                = 833
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