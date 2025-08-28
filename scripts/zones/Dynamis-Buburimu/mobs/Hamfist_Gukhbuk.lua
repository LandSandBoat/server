-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Hamfist Gukhbuk
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
    [ID.mob.HAMFIST_GUKHBUK - 9] = ID.mob.HAMFIST_GUKHBUK, -- Vanguard_Grappler
}

entity.onMobDeath = function(mob, player, optParams)
end

return entity
