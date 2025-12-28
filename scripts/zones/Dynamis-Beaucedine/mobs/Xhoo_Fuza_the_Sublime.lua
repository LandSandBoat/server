-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Xhoo Fuza the Sublime
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
    { x =  204.103, y = -20.079, z =  12.447 }
}

entity.phList =
{
    [ID.mob.XHOO_FUZA_THE_SUBLIME - 1] = ID.mob.XHOO_FUZA_THE_SUBLIME, -- Vanguard_Chanter
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
