-----------------------------------
-- Area: Castle Zvahl Baileys [S]
--  Mob: Demon Condemner
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Demons_Elemental')
end

return entity
