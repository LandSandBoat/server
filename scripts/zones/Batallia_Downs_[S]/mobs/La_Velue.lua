-----------------------------------
-- Area: Batallia Downs [S]
--   NM: La Velue
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -153.108, y = -10.397, z =  15.353 }
}

entity.phList =
{
    [ID.mob.LA_VELUE - 22] = ID.mob.LA_VELUE, -- -314.365 -18.745 -56.016
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 491)
    xi.magian.onMobDeath(mob, player, optParams, set{ 6, 516, 895 })
end

return entity
