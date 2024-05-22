-----------------------------------
-- Area: Aydeewa Subterrane
--  Mob: Qiqirn Archaeologist
-- Note: PH for Bluestreak Gyugyuroon
-----------------------------------
local ID = zones[xi.zone.AYDEEWA_SUBTERRANE]
-----------------------------------
local entity = {}

local bluestreakGyugyuroonPHTable =
{
    [ID.mob.BLUESTREAK_GYUGYUROON - 215] = ID.mob.BLUESTREAK_GYUGYUROON, -- -221.7 13.762 -346.83
    [ID.mob.BLUESTREAK_GYUGYUROON - 214] = ID.mob.BLUESTREAK_GYUGYUROON, -- -219 14.003 -364.83
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, bluestreakGyugyuroonPHTable, 10, 7200) -- 2 hours
end

return entity
