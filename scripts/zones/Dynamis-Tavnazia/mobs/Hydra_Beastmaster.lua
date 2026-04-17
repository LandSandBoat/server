-----------------------------------
-- Area: Dynamis - Tavnazia
--  Mob: Hydra Beastmaster
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Hydras_Hound')
end

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
