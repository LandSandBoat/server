-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Nee Huxa the Judgmental
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
    { x =  171.510, y = -20.410, z = -72.121 }
}

entity.phList =
{
    [ID.mob.NEE_HUXA_THE_JUDGMENTAL - 2] = ID.mob.NEE_HUXA_THE_JUDGMENTAL, -- Vanguard_Inciter
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
