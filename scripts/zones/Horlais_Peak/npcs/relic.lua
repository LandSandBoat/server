-----------------------------------
-- Area: Horlais Peak
--  NPC: <this space intentionally left blank>
-- !pos 450 -40 -31 139
-----------------------------------
local ID = require("scripts/zones/Horlais_Peak/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.TOTSUKANOTSURUGI and
        npcUtil.tradeHas(trade, { xi.items.RANPERRE_GOLDPIECE, xi.items.DIVINE_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.TOTSUKANOTSURUGI })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(13, xi.items.AMANOMURAKUMO)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 13 and
        npcUtil.giveItem(player, { xi.items.AMANOMURAKUMO, { xi.items.MONTIONT_SILVERPIECE, 30 } })
    then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end

return entity
