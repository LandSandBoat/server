-----------------------------------
-- Area: Dragon's Aery
--  NPC: <this space intentionally left blank>
-- !pos -20 -2 61 154
-----------------------------------
local ID = require("scripts/zones/Dragons_Aery/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar("RELIC_IN_PROGRESS") == xi.items.CALIBURN and
        npcUtil.tradeHas(trade, { xi.items.RANPERRE_GOLDPIECE, xi.items.HOLY_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.CALIBURN })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(3, xi.items.EXCALIBUR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 3 and
        npcUtil.giveItem(player, { xi.items.EXCALIBUR, { xi.items.MONTIONT_SILVERPIECE, 30 } })
    then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end

return entity
