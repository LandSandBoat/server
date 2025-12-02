-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Ambusher Antlion
-----------------------------------
mixins = { require('scripts/mixins/families/antlion_ambush') }
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -490.195, y = -4.503, z =  145.451 }
}

entity.phList =
{
    [ID.mob.AMBUSHER_ANTLION - 78] = ID.mob.AMBUSHER_ANTLION, -- -433.309 -4.3 113.841
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 277)
end

return entity
