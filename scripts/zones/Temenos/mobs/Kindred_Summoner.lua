-----------------------------------
-- Area: Temenos Northern Tower
--  Mob: Kindred Summoner
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Kindreds_Elemental')
end

entity.onMobEngage = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
