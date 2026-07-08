-----------------------------------
-- Area: Xarcabard
--  Mob: Frost Gigas
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Gigass_Tiger')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 54, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 55, 2, xi.regime.type.FIELDS)
end

return entity
