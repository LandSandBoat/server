-----------------------------------
-- Area: Carpenters' Landing
--  NPC: <this space intentionally left blank>
-- !pos -99 -0 -514 2
-----------------------------------
local ID = require("scripts/zones/Carpenters_Landing/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:getCharVar("RELIC_IN_PROGRESS") == 15069 and npcUtil.tradeHas(trade, {1454, 1822, 1589, 15069})) then -- currency, shard, necropsyche, stage 4
        player:startEvent(44, 15070)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 44 and npcUtil.giveItem(player, {15070, {1453, 30}})) then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end

return entity
