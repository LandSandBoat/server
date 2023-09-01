-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Vanguard Grappler
-----------------------------------
mixins =
{
    require('scripts/mixins/dynamis_beastmen'),
    require('scripts/mixins/job_special')
}
local ID = zones[xi.zone.DYNAMIS_BUBURIMU]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HAMFIST_GUKHBUK_PH, 10, 1200) -- 20 minutes
end

return entity
