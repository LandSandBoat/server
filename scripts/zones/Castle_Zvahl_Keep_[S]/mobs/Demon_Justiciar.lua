-----------------------------------
-- Area: Castle Zvahl Keep [S]
--  Mob: Demon Justiciar
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Demons_Elemental')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
