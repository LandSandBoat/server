-----------------------------------
-- Area: Beaucedine Glacier
--  Mob: Goblin Trader
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Goblins_Tiger')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 46, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 49, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 50, 2, xi.regime.type.FIELDS)
end

return entity
