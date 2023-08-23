-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Mystrix
-- Gobbie Mystery Box
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/gobbiemysterybox")
-----------------------------------
local entity = {}

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
