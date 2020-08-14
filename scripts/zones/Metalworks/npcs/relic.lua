-----------------------------------
-- Area: Metalworks
--  NPC: <this space intentionally left blank>
-- !pos -20 -11 33 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getCharVar("RELIC_IN_PROGRESS") == 18335 and npcUtil.tradeHas(trade, {1457, 1585, 1589, 18335})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(843, 18336)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 843 and npcUtil.giveItem(player, {18336, {1456, 30}})) then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end
