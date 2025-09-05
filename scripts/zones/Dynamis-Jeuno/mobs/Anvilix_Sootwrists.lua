-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Anvilix Sootwrists
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_JEUNO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -2.267, y =  2.402, z =  105.319 }
}

entity.phList =
{
    [ID.mob.ANVILIX_SOOTWRISTS - 3] = ID.mob.ANVILIX_SOOTWRISTS, -- Vanguard_Smithy       -2.563   2.706   112.752
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
