-----------------------------------
-- Area: Temenos Northern Tower
--  Mob: Telchines Dragoon
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Telchiness_Wyvern')
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
