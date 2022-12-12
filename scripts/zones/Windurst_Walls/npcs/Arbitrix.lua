-----------------------------------
-- Area: Windurst Walls
--  NPC: Arbitrix
-- Gobbie Mystery Box
-- !pos -215.5 0.0 -147.3
-----------------------------------
require("scripts/globals/gobbiemysterybox")
-----------------------------------
local entity = {}

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
