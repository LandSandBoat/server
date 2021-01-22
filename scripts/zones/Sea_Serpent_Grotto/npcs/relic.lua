-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: <this space intentionally left blank>
-- !pos -356 14 -102 176
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getCharVar("RELIC_IN_PROGRESS") == 18311 and npcUtil.tradeHas(trade, {1457, 1579, 1589, 18311}) then -- currency, shard, necropsyche, stage 4
        player:startEvent(11, 18312)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 11 and npcUtil.giveItem(player, {18312, {1456, 30}}) then
        player:confirmTrade()
        player:setCharVar("RELIC_IN_PROGRESS", 0)
    end
end

return entity
