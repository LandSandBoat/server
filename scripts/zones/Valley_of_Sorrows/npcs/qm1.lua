-----------------------------------
-- Area: Valley of Sorrows
--  NPC: qm1 (???)
-- Spawns Adamantoise or Aspidochelone
-- !pos 0 0 -37 59
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
require('scripts/globals/items')
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
end

entity.onTrade = function(player, npc, trade)
    if
        not GetMobByID(ID.mob.ADAMANTOISE):isSpawned() and
        not GetMobByID(ID.mob.ASPIDOCHELONE):isSpawned()
    then
        if
            npcUtil.tradeHasExactly(trade, xi.items.BLUE_PONDWEED) and
            npcUtil.popFromQM(player, npc, ID.mob.ADAMANTOISE)
        then
            player:confirmTrade()
        elseif
            npcUtil.tradeHasExactly(trade, xi.items.RED_PONDWEED) and
            npcUtil.popFromQM(player, npc, ID.mob.ASPIDOCHELONE)
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
