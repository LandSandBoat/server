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

entity.phList =
{
    [ID.mob.DEBHO_PYROHAND - 3] = ID.mob.DEBHO_PYROHAND, -- Vanguard_Thaumaturge
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
