-----------------------------------
-- Area: Xarcabard [S]
--  Mob: Gigas Flogger
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Gigass_Tiger')
end

return entity
