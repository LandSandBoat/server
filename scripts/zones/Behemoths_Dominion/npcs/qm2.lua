-----------------------------------
-- Area: Behemoth's Dominion
--  NPC: qm2 (???)
-- Spawns Behemoth or King Behemoth
-- !pos -267 -19 74 127
-----------------------------------
local ID = require("scripts/zones/Behemoths_Dominion/IDs")
require('scripts/globals/items')
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
end

entity.onTrade = function(player, npc, trade)
    if
        not GetMobByID(ID.mob.BEHEMOTH):isSpawned() and
        not GetMobByID(ID.mob.KING_BEHEMOTH):isSpawned()
    then
        if
            npcUtil.tradeHasExactly(trade, xi.items.BEASTLY_SHANK) and
            npcUtil.popFromQM(player, npc, ID.mob.BEHEMOTH)
        then
            player:confirmTrade()
        elseif
            npcUtil.tradeHasExactly(trade, xi.items.SAVORY_SHANK) and
            npcUtil.popFromQM(player, npc, ID.mob.KING_BEHEMOTH)
        then
            player:confirmTrade()
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.IRREPRESSIBLE_MIGHT)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
