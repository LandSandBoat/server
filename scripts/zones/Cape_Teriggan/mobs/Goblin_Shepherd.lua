-----------------------------------
-- Area: Cape Teriggan
--  Mob: Goblin Shepherd
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Rabbit')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 105, 2, xi.regime.type.FIELDS)
end

return entity
