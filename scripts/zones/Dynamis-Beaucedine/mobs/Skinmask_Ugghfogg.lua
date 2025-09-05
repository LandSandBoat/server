-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Skinmask Ugghfogg
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
    { x =  224.229, y = -0.246, z =  104.842 }
}

entity.phList =
{
    [ID.mob.SKINMASK_UGGHFOGG - 1] = ID.mob.SKINMASK_UGGHFOGG, -- Vanguard_Neckchopper
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
