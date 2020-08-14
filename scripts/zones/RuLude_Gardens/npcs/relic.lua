-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: <this space intentionally left blank>
-- !pos 0 8 -40 243
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getCharVar("RELIC_IN_PROGRESS") == 18293 and npcUtil.tradeHas(trade, {1457, 1576, 1589, 18293})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(10035, 18294)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10035 and npcUtil.giveItem(player, {18294, {1456, 30}})) then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end
