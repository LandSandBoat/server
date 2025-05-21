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
    -- JAILER OF HOPE
    if
        not GetMobByID(ID.mob.JAILER_OF_HOPE):isSpawned() and
        trade:hasItemQty(xi.item.FIRST_VIRTUE, 1) and -- first_virtue
        trade:hasItemQty(xi.item.DEED_OF_PLACIDITY, 1) and -- deed_of_placidity
        trade:hasItemQty(xi.item.HIGH_QUALITY_PHUABO_ORGAN, 1) and -- high-quality_phuabo_organ
        trade:getItemCount() == 3
    then
        player:tradeComplete()
        SpawnMob(ID.mob.JAILER_OF_HOPE):updateClaim(player)
    end
end

return entity
