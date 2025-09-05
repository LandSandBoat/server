-----------------------------------
-- Area: Aydeewa Subterrane
--   NM: Bluestreak Gyugyuroon
-----------------------------------
local ID = zones[xi.zone.AYDEEWA_SUBTERRANE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -219.199, y =  13.483, z = -340.343 }
}

entity.phList =
{
    [ID.mob.BLUESTREAK_GYUGYUROON - 215] = ID.mob.BLUESTREAK_GYUGYUROON, -- -221.7 13.762 -346.83
    [ID.mob.BLUESTREAK_GYUGYUROON - 214] = ID.mob.BLUESTREAK_GYUGYUROON, -- -219 14.003 -364.83
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 464)
end

return entity
