-----------------------------------
-- Area: Castle Zvahl Baileys
--  Mob: Abyssal Demon
-- Note: PH for Marquis Sabnock
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_BAILEYS]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MARQUIS_SABNOCK_PH, 10, 7200) -- 2 hour
end

return entity
