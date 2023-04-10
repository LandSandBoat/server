-----------------------------------
-- Area: Valley of Sorrows
--  NPC: <this space intentionally left blank>
-- !pos -14 -3 56 128
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.MILLENNIUM_HORN and
        npcUtil.tradeHas(trade, { xi.items.RIMILALA_STRIPESHELL, xi.items.MYSTERIAL_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.MILLENNIUM_HORN })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(15, xi.items.GJALLARHORN)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 15 and
        npcUtil.giveItem(player, { xi.items.GJALLARHORN, { xi.items.LUNGO_NANGO_JADESHELL, 30 } })
    then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end

return entity
