-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Lyncean Juwgneg
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_BUBURIMU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.LYNCEAN_JUWGNEG - 7] = ID.mob.LYNCEAN_JUWGNEG, -- Vanguard_Predator
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
