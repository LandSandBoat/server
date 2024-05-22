-----------------------------------
-- Area: Buburimu Peninsula (118)
--  Mob: Zu
-- Note: PH for Helldiver
-----------------------------------
local ID = zones[xi.zone.BUBURIMU_PENINSULA]
-----------------------------------
local entity = {}

local helldiverPHTable =
{
    [ID.mob.HELLDIVER - 1] = ID.mob.HELLDIVER, -- 509.641 0.151 -267.664
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, helldiverPHTable, 10, 3600) -- 1 hour minimum
end

return entity
