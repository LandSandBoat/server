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

entity.phList =
{
    [ID.mob.SOGHO_ADDERHANDLER - 2] = ID.mob.SOGHO_ADDERHANDLER, -- Vanguard_Beasttender
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
