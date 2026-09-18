-----------------------------------
-- Area: Attohwa Chasm
--  NPC: ???
-- !pos -402.574 3.999 -202.750 7
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local nm = GetMobByID(ID.mob.FEELER_ANTLION)
    if
        nm and
        not nm:isSpawned() and
        npcUtil.tradeMatches(trade, { { xi.item.ANTLION_TRAP, 1 } })
    then
        player:tradeComplete()
        player:messageSpecial(ID.text.ANTLION_TRAP_SET, xi.item.ANTLION_TRAP)
        SpawnMob(ID.mob.FEELER_ANTLION):updateClaim(player)
        npc:setStatus(xi.status.DISAPPEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.OCCASIONAL_LUMPS)
end

return entity
