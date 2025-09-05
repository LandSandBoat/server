-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Heavymail Djidzbad
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
    { x =  265.857, y = -0.727, z =  68.593 }
}

entity.phList =
{
    [ID.mob.HEAVYMAIL_DJIDZBAD - 1] = ID.mob.HEAVYMAIL_DJIDZBAD, -- Vanguard_Trooper
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
