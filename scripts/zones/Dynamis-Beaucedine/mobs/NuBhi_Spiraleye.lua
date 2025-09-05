-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: NuBhi Spiraleye
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BEAUCEDINE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  395.555, y = -0.405, z = -194.430 }
}

entity.phList =
{
    [ID.mob.NUBHI_SPIRALEYE - 1] = ID.mob.NUBHI_SPIRALEYE, -- Vanguard_Minstrel
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
