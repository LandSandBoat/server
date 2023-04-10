-----------------------------------
-- Area: Ru'Aun Gardens
--  NPC: <this space intentionally left blank>
-- !pos -241 -12 332 130
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.GAE_ASSAIL and
        npcUtil.tradeHasExactly(trade, { xi.items.RIMILALA_STRIPESHELL, xi.items.STELLAR_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.GAE_ASSAIL })
    then -- currency, shard, necropsyche, stage 4
        player:startEvent(60, xi.items.GUNGNIR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 60 and
        npcUtil.giveItem(player, { xi.items.GUNGNIR, { xi.items.LUNGO_NANGO_JADESHELL, 30 } })
    then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end

return entity
