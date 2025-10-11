-----------------------------------
-- Area: Den of Rancor
--  Mob: Tonberry Beleaguerer
-- Note: PH for Bistre-hearted Malberry
-----------------------------------
mixins = { require('scripts/mixins/families/tonberry') }
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Tonberrys_Elemental')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 798, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 799, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 800, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BISTRE_HEARTED_MALBERRY, 10, 3600) -- 1 hour
end

return entity
