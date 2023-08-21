-----------------------------------
-- Area: Al'Taieu
--  NPC: qm_jailer_of_prudence (???)
-- Allows players to spawn the Jailer of Prudence by trading the Third Virtue, Deed of Sensibility, and High-Quality Hpemde Organ to a ???.
-- !pos , 706 -1 22
-----------------------------------
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- JAILER OF PRUDENCE
    if
        not GetMobByID(ID.mob.JAILER_OF_PRUDENCE_1):isSpawned() and
        not GetMobByID(ID.mob.JAILER_OF_PRUDENCE_2):isSpawned() and
        trade:hasItemQty(xi.item.THIRD_VIRTUE, 1) and -- third_virtue
        trade:hasItemQty(xi.item.DEED_OF_SENSIBILITY, 1) and -- deed_of_sensibility
        trade:hasItemQty(xi.item.HIGH_QUALITY_HPEMDE_ORGAN, 1) and -- high-quality_hpemde_organ
        trade:getItemCount() == 3
    then
        player:tradeComplete()
        SpawnMob(ID.mob.JAILER_OF_PRUDENCE_1):updateClaim(player) -- Spawn Jailer of Prudence 1
        SpawnMob(ID.mob.JAILER_OF_PRUDENCE_2)                     -- Spawn Jailer of Prudence 2 unclaimed
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
