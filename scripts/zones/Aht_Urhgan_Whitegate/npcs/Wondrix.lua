-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Wondrix
-- Gobbie Mystery Box
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/settings")
require("scripts/globals/gobbiemysterybox")
-----------------------------------
local entity = {}

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
    OTHER_BAD_TRADE         = 992
}

entity.onTrade = function(player, npc, trade)
    xi.mystery.onTrade(player, npc, trade, events)
end

entity.onTrigger = function(player, npc)
    xi.mystery.onTrigger(player, npc, events)
end

entity.onEventUpdate = function(player, csid, option)
    xi.mystery.onEventUpdate(player, csid, option, events)
end

entity.onEventFinish = function(player, csid, option)
    xi.mystery.onEventFinish(player, csid, option, events)
end

return entity
