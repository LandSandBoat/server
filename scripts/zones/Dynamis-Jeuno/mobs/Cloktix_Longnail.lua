-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Cloktix Longnail
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_JEUNO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.CLOKTIX_LONGNAIL - 2] = ID.mob.CLOKTIX_LONGNAIL, -- Vanguard_Armorer      -17.690  8.321   -51.944
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
