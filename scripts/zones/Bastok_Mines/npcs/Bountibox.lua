-----------------------------------
-- Area: Bastok Mines
--  NPC: Bountibox
-- Gobbie Mystery Box
-----------------------------------
local entity = {}

local events =
{
    INTRO                   = 6000,
    DEFAULT                 = 6001,
    HOLDING_ITEM            = 6002,
    TRADE                   = 6003,
    BAD_TRADE               = 6004,
    DAILY_COOLDOWN          = 6005,
    HIT_MAX                 = 6006,
    RESULT                  = 6009,
    KEY_TRADE               = 6010,
    NO_THANKS               = 6011,
    FULL_INV                = 6012,
    OTHER_BAD_TRADE         = 6013
}

entity.onTrade = function(player, npc, trade)
    xi.gobbieMysteryBox.onTrade(player, npc, trade, events)
end

entity.onTrigger = function(player, npc)
    xi.gobbieMysteryBox.onTrigger(player, npc, events)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.gobbieMysteryBox.onEventUpdate(player, csid, option, events)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.gobbieMysteryBox.onEventFinish(player, csid, option, events)
end

return entity
