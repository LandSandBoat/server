-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: GuKhu Dukesniper
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
    { x =  352.906, y = -0.345, z = -123.037 }
}

entity.phList =
{
    [ID.mob.GUKHU_DUKESNIPER - 1] = ID.mob.GUKHU_DUKESNIPER, -- Vanguard_Mason
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
