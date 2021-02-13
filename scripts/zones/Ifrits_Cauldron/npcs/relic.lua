-----------------------------------
-- Area: Ifrit's Cauldron
--  NPC: <this space intentionally left blank>
-- !pos -18 40 20 205
-----------------------------------
local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar("RELIC_IN_PROGRESS") == 18329 and
        npcUtil.tradeHas(trade, {1451, 1582, 1589, 18329}) -- currency, shard, necropsyche, stage 4
    then
        player:startEvent(32, 18330)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 32 and npcUtil.giveItem(player, {18330, {1450, 30}}) then
        player:setCharVar("RELIC_IN_PROGRESS", 0)
        player:confirmTrade()
    end
end

return entity
