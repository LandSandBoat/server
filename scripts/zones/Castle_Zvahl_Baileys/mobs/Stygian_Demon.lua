-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--  Mob: Stygian Demon
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Demons_Elemental')
end

return entity
