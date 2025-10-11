-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Giant Sentry
-- Note: PH for Rhoitos and Eurytos
-----------------------------------
local ID = zones[xi.zone.MIDDLE_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Gigass_Bat')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 783, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 784, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.RHOITOS, 5, math.random(7200, 14400)) -- 2 to 4 hours (could not find info, so using Ogygos' cooldown)
    xi.mob.phOnDespawn(mob, ID.mob.EURYTOS, 5, math.random(7200, 14400)) -- 2 to 4 hours (could not find info, so using Ogygos' cooldown)
end

return entity
