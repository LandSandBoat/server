-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Gibberox Pimplebeak
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
    { x = -36.065, y = -39.581, z = -221.620 }
}

entity.phList =
{
    [ID.mob.GIBBEROX_PIMPLEBEAK - 1] = ID.mob.GIBBEROX_PIMPLEBEAK, -- Vanguard_Enchanter
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
