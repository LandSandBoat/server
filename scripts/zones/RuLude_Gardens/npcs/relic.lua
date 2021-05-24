-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: <this space intentionally left blank>
-- !pos 0 8 -40 243
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getCharVar("RELIC_IN_PROGRESS") == xi.items.ABADDON_KILLER and npcUtil.tradeHas(trade, {xi.items.TEN_THOUSAND_BYNE_BILL, xi.items.SERAPHIC_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.ABADDON_KILLER})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(10035, xi.items.BRAVURA)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 10035 and npcUtil.giveItem(player, {xi.items.BRAVURA, {xi.items.ONE_HUNDRED_BYNE_BILL, 30}})) then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end

return entity
