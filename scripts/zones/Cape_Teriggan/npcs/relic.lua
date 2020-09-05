-----------------------------------
-- Area: Cape Teriggan
--  NPC: <this space intentionally left blank>
-- !pos 73 4 -174 113
-----------------------------------
local ID = require("scripts/zones/Cape_Teriggan/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getCharVar("RELIC_IN_PROGRESS") == 18347 and npcUtil.tradeHas(trade, {1454, 1583, 1589, 18347})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(18, 18348)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 18 and npcUtil.giveItem(player, {18348, {1453, 30}})) then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end
