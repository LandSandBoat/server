-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Xaa Chau the Roctalon
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
    { x =  115.857, y = -20.420, z = -154.987 }
}

entity.phList =
{
    [ID.mob.XAA_CHAU_THE_ROCTALON - 1] = ID.mob.XAA_CHAU_THE_ROCTALON, -- Vanguard_Sentinel
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
