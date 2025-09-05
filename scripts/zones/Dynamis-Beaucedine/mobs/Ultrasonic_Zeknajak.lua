-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Ultrasonic Zeknajak
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
    { x =  281.551, y = -0.348, z =  207.860 }
}

entity.phList =
{
    [ID.mob.ULTRASONIC_ZEKNAJAK - 3] = ID.mob.ULTRASONIC_ZEKNAJAK, -- Vanguard_Bugler
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
