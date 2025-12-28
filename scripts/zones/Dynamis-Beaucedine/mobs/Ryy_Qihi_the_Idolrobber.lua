-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Ryy Qihi the Idolrobber
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
    { x =  285.560, y = -20.380, z = -149.590 }
}

entity.phList =
{
    [ID.mob.RYY_QIHI_THE_IDOLROBBER - 2] = ID.mob.RYY_QIHI_THE_IDOLROBBER, -- Vanguard_Liberator
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
