-----------------------------------
-- Area: Qufim Island
--  Mob: Giant Trapper
-- Note: PH for Slippery Sucker
-----------------------------------
local ID = zones[xi.zone.QUFIM_ISLAND]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Gigass_Leech')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 44, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 45, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SLIPPERY_SUCKER, 10, 600) -- 10 minutes
end

return entity
