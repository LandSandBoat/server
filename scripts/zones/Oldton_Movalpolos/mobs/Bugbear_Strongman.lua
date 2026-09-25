-----------------------------------
-- Area: Oldton Movalpolos
--   NM: Bugbear Strongman
-----------------------------------
local ID = zones[xi.zone.OLDTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  60.728, y =  15.487, z = -118.886 }
}

entity.phList =
{
    [ID.mob.BUGBEAR_STRONGMAN[1] - 1] = ID.mob.BUGBEAR_STRONGMAN[1], -- Confirmed on retail
    [ID.mob.BUGBEAR_STRONGMAN[2] - 1] = ID.mob.BUGBEAR_STRONGMAN[2], -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 244)
    xi.magian.onMobDeath(mob, player, optParams, set{ 5, 515, 894 })
end

return entity
