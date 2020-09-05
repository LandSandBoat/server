-----------------------------------
-- Area: Dragon's Aery
--  NPC: <this space intentionally left blank>
-- !pos -20 -2 61 154
-----------------------------------
local ID = require("scripts/zones/Dragons_Aery/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getCharVar("RELIC_IN_PROGRESS") == 18275 and npcUtil.tradeHas(trade, {1454, 1573, 1589, 18275})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(3, 18276)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 3 and npcUtil.giveItem(player, {18276, {1453, 30}})) then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end
