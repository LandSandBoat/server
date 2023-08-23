-----------------------------------
-- Area: Behemoth's Dominion
--  NPC: qm2 (???)
-- Spawns Behemoth or King Behemoth
-- !pos -267 -19 74 127
-----------------------------------
local ID = zones[xi.zone.BEHEMOTHS_DOMINION]
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
            npcUtil.tradeHasExactly(trade, xi.item.BEASTLY_SHANK) and
            npcUtil.popFromQM(player, npc, ID.mob.BEHEMOTH)
        then
            player:confirmTrade()
        elseif
            npcUtil.tradeHasExactly(trade, xi.item.SAVORY_SHANK) and
            npcUtil.popFromQM(player, npc, ID.mob.KING_BEHEMOTH)
        then
            player:confirmTrade()
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.IRREPRESSIBLE_MIGHT)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
