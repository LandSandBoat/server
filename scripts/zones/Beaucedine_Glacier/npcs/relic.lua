-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: <this space intentionally left blank>
-- !pos -89 0 -374 111
-----------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.VALHALLA and
        npcUtil.tradeHas(trade, { xi.items.RANPERRE_GOLDPIECE, xi.items.INTRICATE_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.VALHALLA })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(139, xi.items.RAGNAROK)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 139 and
        npcUtil.giveItem(player, { xi.items.RAGNAROK, { xi.items.MONTIONT_SILVERPIECE, 30 } })
    then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end

return entity
