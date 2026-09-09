-----------------------------------
-- Area: Lufaise_Meadows
--  Mob: Gigas Warwolf
-----------------------------------
mixins =
{
    require('scripts/mixins/fomor_hate'),
    require('scripts/mixins/pet_resummon'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 4, 'Gigass_Sheep')
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('fomorHateAdj', 1)
end

return entity
