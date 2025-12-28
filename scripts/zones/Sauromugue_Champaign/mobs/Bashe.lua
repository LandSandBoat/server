-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Bashe
-----------------------------------
local ID = zones[xi.zone.SAUROMUGUE_CHAMPAIGN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  537.188, y =  6.167, z = -11.067 }
}

entity.phList =
{
    [ID.mob.BASHE - 6] = ID.mob.BASHE, -- 537.188 6.167 -11.067
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 273)
    xi.magian.onMobDeath(mob, player, optParams, set{ 284 })
end

return entity
