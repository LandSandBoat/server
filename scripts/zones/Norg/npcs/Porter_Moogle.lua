-----------------------------------
-- Area: Norg
--  NPC: Porter Moogle
-- Type: Storage Moogle
-- !zone 252
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
require("scripts/globals/porter_moogle_util")

local e =
{
    TALK_EVENT_ID       =   244,
    STORE_EVENT_ID      =   245,
    RETRIEVE_EVENT_ID   =   246,
    ALREADY_STORED_ID   =   247,
    MAGIAN_TRIAL_ID     =   248
}

function onTrade(player, npc, trade)
    porterMoogleTrade(player, trade, e)
end

function onTrigger(player, npc)
    -- No idea what the params are, other than event ID and gil.
    player:startEvent(e.TALK_EVENT_ID, 0x6FFFFF, 0x01, 0x06DD, 0x27, 0x7C7E, 0x15, player:getGil(), 0x03E8)
end

function onEventUpdate(player, csid, option)
    porterEventUpdate(player, csid, option, e.RETRIEVE_EVENT_ID)
end

function onEventFinish(player, csid, option)
    porterEventFinish(player, csid, option, e.TALK_EVENT_ID)
end
