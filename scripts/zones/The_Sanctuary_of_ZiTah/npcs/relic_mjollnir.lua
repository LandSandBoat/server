-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  NPC: <this space intentionally left blank>
-- !pos -18 0 55 121
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local currentRelic = player:getCharVar("RELIC_IN_PROGRESS")

    if
        currentRelic == xi.items.GULLINTANI and
        npcUtil.tradeHas(trade, { xi.items.RANPERRE_GOLDPIECE, xi.items.HEAVENLY_FRAGMENT, xi.items.SHARD_OF_NECROPSYCHE, xi.items.GULLINTANI })
    then
        -- currency, shard, necropsyche, stage 4
        player:startEvent(216, xi.items.MJOLLNIR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 216 and
        npcUtil.giveItem(player, { xi.items.MJOLLNIR, { xi.items.MONTIONT_SILVERPIECE, 30 } })
    then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end

return entity
