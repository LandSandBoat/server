-----------------------------------
-- Area: Horlais Peak
--  NPC: <this space intentionally left blank>
-- !pos 450 -40 -31 139
-----------------------------------
local ID = require("scripts/zones/Horlais_Peak/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getCharVar("RELIC_IN_PROGRESS") == 18317 and npcUtil.tradeHas(trade, {1454, 1580, 1589, 18317})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(13, 18318)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 13 and npcUtil.giveItem(player, {18318, {1453, 30}})) then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end
