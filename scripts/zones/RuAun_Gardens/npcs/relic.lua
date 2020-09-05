-----------------------------------
-- Area: Ru'Aun Gardens
--  NPC: <this space intentionally left blank>
-- !pos -241 -12 332 130
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getCharVar("RELIC_IN_PROGRESS") == 18299 and npcUtil.tradeHas(trade, {1451, 1578, 1589, 18299})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(60, 18300)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 60 and npcUtil.giveItem(player, {18300, {1450, 30}})) then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end
