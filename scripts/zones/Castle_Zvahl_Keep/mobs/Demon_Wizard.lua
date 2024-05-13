-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Demon Wizard
-- Note: PH for Baron Vapula
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_KEEP]
-----------------------------------
local entity = {}

local baronPHTable =
{
    [ID.mob.BARON_VAPULA - 3] = ID.mob.BARON_VAPULA, -- -254.000 -52.125 86.000
    [ID.mob.BARON_VAPULA - 1] = ID.mob.BARON_VAPULA, -- -227.007 -52.125 83.768
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, baronPHTable, 10, math.random(3600, 28800)) -- 1 to 8 hours
end

return entity
