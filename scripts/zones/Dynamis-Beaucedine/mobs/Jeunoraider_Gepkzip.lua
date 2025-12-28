-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Jeunoraider Gepkzip
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
    { x =  234.322, y = -0.416, z = -36.316 }
}

entity.phList =
{
    [ID.mob.JEUNORAIDER_GEPKZIP - 1] = ID.mob.JEUNORAIDER_GEPKZIP, -- Vanguard_Backstabber
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
