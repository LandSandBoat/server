-----------------------------------
-- Area: Dragons Aery
--  NPC: qm0 (???)
-- Spawns Fafnir or Nidhogg
-- !pos -81 32 2 178
-----------------------------------
local ID = require("scripts/zones/Dragons_Aery/IDs")
require('scripts/globals/items')
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
end

entity.onTrade = function(player, npc, trade)
    if
        not GetMobByID(ID.mob.FAFNIR):isSpawned() and
        not GetMobByID(ID.mob.NIDHOGG):isSpawned()
    then
        if
            npcUtil.tradeHasExactly(trade, xi.items.HONEY_WINE) and
            npcUtil.popFromQM(player, npc, ID.mob.FAFNIR)
        then
            player:confirmTrade()
        elseif
            npcUtil.tradeHasExactly(trade, xi.items.SWEET_TEA) and
            npcUtil.popFromQM(player, npc, ID.mob.NIDHOGG)
        then
            player:confirmTrade()
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
