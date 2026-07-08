-----------------------------------
-- Area: Al'Taieu
--  NPC: qm_jailer_of_prudence (???)
-- Allows players to spawn the Jailer of Prudence by trading the Third Virtue, Deed of Sensibility, and High-Quality Hpemde Organ to a ???.
-- !pos , 706 -1 22
-----------------------------------
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, { xi.item.THIRD_VIRTUE, xi.item.DEED_OF_SENSIBILITY, xi.item.HIGH_QUALITY_HPEMDE_ORGAN }) and
        npcUtil.popFromQM(player, npc, { ID.mob.JAILER_OF_PRUDENCE, ID.mob.JAILER_OF_PRUDENCE + 1 })
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(202)
end

return entity
