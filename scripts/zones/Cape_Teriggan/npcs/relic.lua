-----------------------------------
-- Area: Cape Teriggan
--  NPC: <this space intentionally left blank>
-- !pos 73 4 -174 113
-----------------------------------
local ID = require("scripts/zones/Cape_Teriggan/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.FUTATOKOROTO and
        npcUtil.tradeHas(trade, { xi.items.RANPERRE_GOLDPIECE, xi.items.SNARLED_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.FUTATOKOROTO })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(18, xi.items.YOICHINOYUMI)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 18 and
        npcUtil.giveItem(player, { xi.items.YOICHINOYUMI, { xi.items.MONTIONT_SILVERPIECE, 30 } })
    then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end

return entity
