-----------------------------------
-- Area: Metalworks
--  NPC: <this space intentionally left blank>
-- !pos -20 -11 33 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.FERDINAND and
        npcUtil.tradeHas(trade, { xi.items.TEN_THOUSAND_BYNE_BILL, xi.items.ETHEREAL_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.FERDINAND })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(843, xi.items.ANNIHILATOR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 843 and
        npcUtil.giveItem(player, { xi.items.ANNIHILATOR, { xi.items.ONE_HUNDRED_BYNE_BILL, 30 } })
    then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end

return entity
