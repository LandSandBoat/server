-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Spinalsucker Galflmall
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
    { x =  371.886, y =  0.002, z =  33.839 }
}

entity.phList =
{
    [ID.mob.SPINALSUCKER_GALFLMALL - 1] = ID.mob.SPINALSUCKER_GALFLMALL, -- Vanguard_Vexer
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
