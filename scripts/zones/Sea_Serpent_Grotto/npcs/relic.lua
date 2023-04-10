-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: <this space intentionally left blank>
-- !pos -356 14 -102 176
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.YOSHIMITSU and
        npcUtil.tradeHas(trade, { xi.items.TEN_THOUSAND_BYNE_BILL, xi.items.DEMONIAC_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.YOSHIMITSU })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(11, xi.items.KIKOKU)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 11 and
        npcUtil.giveItem(player, { xi.items.KIKOKU, { xi.items.ONE_HUNDRED_BYNE_BILL, 30 } })
    then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end

return entity
