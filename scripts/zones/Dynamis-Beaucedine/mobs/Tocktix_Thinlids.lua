-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Tocktix Thinlids
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
    { x =  59.306, y = -40.504, z = -128.886 }
}

entity.phList =
{
    [ID.mob.TOCKTIX_THINLIDS - 2] = ID.mob.TOCKTIX_THINLIDS, -- Vanguard_Tinkerer
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
