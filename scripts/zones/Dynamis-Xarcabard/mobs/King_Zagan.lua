-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: King Zagan
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DYNAMIS_XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.KING_ZAGAN - 12] = ID.mob.KING_ZAGAN, -- Kindred_Dragoon
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
