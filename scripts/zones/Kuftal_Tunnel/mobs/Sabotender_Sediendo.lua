-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Sabotender Sediendo
-- Note: Place Holder for Sabotender Mariachi
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
local entity = {}

local mariachiPHTable =
{
    [ID.mob.SABOTENDER_MARIACHI - 9] = ID.mob.SABOTENDER_MARIACHI, -- -17.217 -0.956 -57.647
    [ID.mob.SABOTENDER_MARIACHI - 6] = ID.mob.SABOTENDER_MARIACHI, -- -41.000 -0.488 -31.000
    [ID.mob.SABOTENDER_MARIACHI - 5] = ID.mob.SABOTENDER_MARIACHI, -- -33.717 -0.448 -43.478
    [ID.mob.SABOTENDER_MARIACHI - 3] = ID.mob.SABOTENDER_MARIACHI, -- -41.000 0.088 -3.000
    [ID.mob.SABOTENDER_MARIACHI - 2] = ID.mob.SABOTENDER_MARIACHI, -- -54.912 0.347 -1.681
    [ID.mob.SABOTENDER_MARIACHI - 1] = ID.mob.SABOTENDER_MARIACHI, -- -58.807 -0.327 -8.531
    [ID.mob.SABOTENDER_MARIACHI + 1] = ID.mob.SABOTENDER_MARIACHI, -- -82.074 -0.450 -0.738
    [ID.mob.SABOTENDER_MARIACHI + 2] = ID.mob.SABOTENDER_MARIACHI, -- -84.721 -0.325 -2.861
    [ID.mob.SABOTENDER_MARIACHI + 3] = ID.mob.SABOTENDER_MARIACHI, -- -45.000 -0.115 39.000
    [ID.mob.SABOTENDER_MARIACHI + 4] = ID.mob.SABOTENDER_MARIACHI, -- -38.791 0.230 26.579
    [ID.mob.SABOTENDER_MARIACHI + 5] = ID.mob.SABOTENDER_MARIACHI, -- -34.263 -0.512 30.437
    [ID.mob.SABOTENDER_MARIACHI + 7] = ID.mob.SABOTENDER_MARIACHI, -- -23.543 -0.396 59.578
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 738, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, mariachiPHTable, 5, math.random(10800, 28800)) -- 3 to 8 hours
end

return entity
