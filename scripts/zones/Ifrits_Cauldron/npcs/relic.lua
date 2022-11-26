-----------------------------------
-- Area: Ifrit's Cauldron
--  NPC: <this space intentionally left blank>
-- !pos -18 40 20 205
-----------------------------------
local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.THYRUS and
        npcUtil.tradeHas(trade, { xi.items.RIMILALA_STRIPESHELL, xi.items.CELESTIAL_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.THYRUS }) -- currency, shard, necropsyche, stage 4
    then
        player:startEvent(32, xi.items.CLAUSTRUM)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 32 and
        npcUtil.giveItem(player, { xi.items.CLAUSTRUM, { xi.items.LUNGO_NANGO_JADESHELL, 30 } })
    then
        player:setCharVar("RELIC_IN_PROGRESS", 0)
        player:confirmTrade()
    end
end

return entity
