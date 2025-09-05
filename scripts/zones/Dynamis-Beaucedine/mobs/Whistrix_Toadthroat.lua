-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Whistrix Toadthroat
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
    { x =  141.064, y = -40.892, z = -27.014 }
}

entity.phList =
{
    [ID.mob.WHISTRIX_TOADTHROAT - 1] = ID.mob.WHISTRIX_TOADTHROAT, -- Vanguard_Maestro
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
