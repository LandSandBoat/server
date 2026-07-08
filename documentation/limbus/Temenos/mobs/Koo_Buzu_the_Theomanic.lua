-----------------------------------
-- Area: Temenos Northern Tower
--  Mob: Koo Buzu the Theomanic
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Yagudos_Elemental')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
