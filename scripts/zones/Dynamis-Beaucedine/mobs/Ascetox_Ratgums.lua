-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Ascetox Ratgums
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
    { x = -48.262, y = -40.286, z = -206.177 }
}

entity.phList =
{
    [ID.mob.ASCETOX_RATGUMS - 2] = ID.mob.ASCETOX_RATGUMS, -- Vanguard_Shaman
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
