-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Morblox Chubbychin
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
    [ID.mob.MORBLOX_CHUBBYCHIN - 2] = ID.mob.MORBLOX_CHUBBYCHIN, -- Vanguard_Necromancer
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
