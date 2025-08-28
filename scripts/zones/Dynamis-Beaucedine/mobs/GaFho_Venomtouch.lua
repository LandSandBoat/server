-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: GaFho Venomtouch
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
    [ID.mob.GAFHO_VENOMTOUCH - 1] = ID.mob.GAFHO_VENOMTOUCH, -- Vanguard_Constable
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
