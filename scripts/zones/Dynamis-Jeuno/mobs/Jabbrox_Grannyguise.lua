-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Jabbrox Grannyguise
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
    [ID.mob.JABBROX_GRANNYGUISE - 3] = ID.mob.JABBROX_GRANNYGUISE, -- Vanguard_Enchanter    0.371    2.663   115.674
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
