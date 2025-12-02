-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Gigas Foreman
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Gigass_Spider')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 733, 1, xi.regime.type.GROUNDS)
end

return entity
