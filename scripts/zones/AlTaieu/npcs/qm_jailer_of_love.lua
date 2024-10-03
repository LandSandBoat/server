-----------------------------------
-- Area: Al'Taieu
--  NPC: qm_jailer_of_love (???)
-- Allows players to spawn the Jailer of Love by trading the Fourth Virtue, Fifth Virtue and Sixth Virtue to a ???.
-- Allows players to spawn Absolute Virtue by killing Jailer of Love.
-- !pos , 431 -0 -603
-----------------------------------
local ID = zones[xi.zone.ALTAIEU]
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        not GetMobByID(ID.mob.JAILER_OF_LOVE):isSpawned() and
        not GetMobByID(ID.mob.ABSOLUTE_VIRTUE):isSpawned() and
        trade:hasItemQty(xi.item.FOURTH_VIRTUE, 1) and
        trade:hasItemQty(xi.item.FIFTH_VIRTUE, 1) and
        trade:hasItemQty(xi.item.SIXTH_VIRTUE, 1) and
        trade:getItemCount() == 3
    then
        player:tradeComplete()
        SpawnMob(ID.mob.JAILER_OF_LOVE):updateClaim(player)
    end
end

return entity
