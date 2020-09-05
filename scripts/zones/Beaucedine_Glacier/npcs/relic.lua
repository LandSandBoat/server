-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: <this space intentionally left blank>
-- !pos -89 0 -374 111
-----------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getCharVar("RELIC_IN_PROGRESS") == 18281 and npcUtil.tradeHas(trade, {1454, 1574, 1589, 18281})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(139, 18282)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 139 and npcUtil.giveItem(player, {18282, {1453, 30}})) then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end
