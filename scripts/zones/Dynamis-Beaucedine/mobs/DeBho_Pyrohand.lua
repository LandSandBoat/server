-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: DeBho Pyrohand
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
    { x =  325.616, y = -0.345, z = -189.671 }
}

entity.phList =
{
    [ID.mob.DEBHO_PYROHAND - 3] = ID.mob.DEBHO_PYROHAND, -- Vanguard_Thaumaturge
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
