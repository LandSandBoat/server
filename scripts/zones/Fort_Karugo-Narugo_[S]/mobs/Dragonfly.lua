-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--  Mob: Dragonfly
-- Note: PH for Demoiselle Desolee
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
local entity = {}

local demoisellePHTable =
{
    [ID.mob.DEMOISELLE_DESOLEE + 8] = ID.mob.DEMOISELLE_DESOLEE,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, demoisellePHTable, 5, 3600) -- 1 hour
end

return entity
