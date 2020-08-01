-----------------------------------
-- Area: Castle Oztroja
--  NPC: <this space intentionally left blank>
-- !pos -104 -73 85 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getCharVar("RELIC_IN_PROGRESS") == 18263 and npcUtil.tradeHas(trade, {1457, 1571, 1589, 18263})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(59, 18264)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 59 and npcUtil.giveItem(player, {18264, {1456, 30}})) then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end
