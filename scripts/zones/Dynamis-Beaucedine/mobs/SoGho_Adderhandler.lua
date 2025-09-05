-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: SoGho Adderhandler
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
    { x =  396.052, y =  0.005, z = -125.784 }
}

entity.phList =
{
    [ID.mob.SOGHO_ADDERHANDLER - 2] = ID.mob.SOGHO_ADDERHANDLER, -- Vanguard_Beasttender
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
