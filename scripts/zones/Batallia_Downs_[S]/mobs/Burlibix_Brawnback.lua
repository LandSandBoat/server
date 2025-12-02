-----------------------------------
-- Area: Batallia Downs [S]
--   NM: Burlibix Brawnback
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -152.000, y = -9.200, z =  464.000 }
}

entity.phList =
{
    [ID.mob.BURLIBIX_BRAWNBACK - 1] = ID.mob.BURLIBIX_BRAWNBACK,
    [ID.mob.BURLIBIX_BRAWNBACK + 3] = ID.mob.BURLIBIX_BRAWNBACK,
}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.STUN_MEVA, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 494)
end

return entity
