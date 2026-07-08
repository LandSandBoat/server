-----------------------------------
-- Area: Al'Taieu
--  NPC: qm_jailer_of_hope (???)
-- Allows players to spawn the Jailer of Hope by trading the First Virtue, Deed of Placidity and HQ Phuabo Organ to a ???.
-- !pos -693 -1 -62 33
-----------------------------------
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, { xi.item.FIRST_VIRTUE, xi.item.DEED_OF_PLACIDITY, xi.item.HIGH_QUALITY_PHUABO_ORGAN }) and
        npcUtil.popFromQM(player, npc, ID.mob.JAILER_OF_HOPE)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(200)
end

return entity
