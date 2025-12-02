-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Maat
-- Genkai 5 Fight
-----------------------------------
mixins = { require('scripts/mixins/families/maat') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Maats_Wyvern')
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
