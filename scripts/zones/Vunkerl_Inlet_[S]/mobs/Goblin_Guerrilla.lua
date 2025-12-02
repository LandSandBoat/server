-----------------------------------
-- Area: Vunkerl Inlet [S]
--   NM: Goblin_Guerrilla
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Bat')
end

return entity
