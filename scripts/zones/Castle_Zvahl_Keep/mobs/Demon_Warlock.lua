-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Demon Warlock
-- Note: PH for Viscount Morax
-----------------------------------
mixins = { require('scripts/mixins/pet_resummon') }
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_KEEP]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Demons_Elemental')
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.VISCOUNT_MORAX, 10, 1) -- No respawn
end

return entity
