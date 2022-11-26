-----------------------------------
-- Area: Lower Jeuno
--  NPC: Sweepstox
-- Gobbie Mystery Box
-----------------------------------
require("scripts/globals/gobbiemysterybox")
-----------------------------------
local entity = {}

local events =
{
    INTRO           = 20055,
    DEFAULT         = 20056,
    HOLDING_ITEM    = 20057,
    TRADE           = 20058,
    BAD_TRADE       = 20059,
    DAILY_COOLDOWN  = 20060,
    HIT_MAX         = 20061,
    RESULT          = 20064,
    KEY_TRADE       = 20065,
    NO_THANKS       = 20066,
    FULL_INV        = 20067,
    OTHER_BAD_TRADE = 20068
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
