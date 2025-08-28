-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Moltenox Stubthumbs
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
    [ID.mob.MOLTENOX_STUBTHUMBS - 2] = ID.mob.MOLTENOX_STUBTHUMBS, -- Vanguard_Smithy
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
