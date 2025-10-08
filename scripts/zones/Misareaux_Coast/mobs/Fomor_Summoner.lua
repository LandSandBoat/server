-----------------------------------
-- Area: Misareaux_Coast
--  Mob: Fomor Summoner
-----------------------------------
mixins = { require('scripts/mixins/fomor_hate') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 2, 'Fomors_Elemental')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
