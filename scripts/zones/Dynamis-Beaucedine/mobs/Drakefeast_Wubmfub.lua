-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Drakefeast Wubmfub
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
    { x =  278.297, y =  0.185, z =  218.604 }
}

entity.phList =
{
    [ID.mob.DRAKEFEAST_WUBMFUB - 2] = ID.mob.DRAKEFEAST_WUBMFUB, -- Vanguard_Impaler
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
