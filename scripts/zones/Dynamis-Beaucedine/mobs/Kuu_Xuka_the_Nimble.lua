-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Kuu Xuka the Nimble
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special'),
    require('scripts/mixins/remove_doom')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BEAUCEDINE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  205.891, y = -20.500, z = -82.578 }
}

entity.phList =
{
    [ID.mob.KUU_XUKA_THE_NIMBLE - 1] = ID.mob.KUU_XUKA_THE_NIMBLE, -- Vanguard_Assassin
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
