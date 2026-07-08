-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Vanguard Necromancer
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
    xi.pet.setMobPet(mob, 1, 'Vanguards_Avatar')
end

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

return entity
