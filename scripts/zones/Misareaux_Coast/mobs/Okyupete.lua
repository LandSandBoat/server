-----------------------------------
-- Area: Misareaux Coast
--   NM: Okyupete
-----------------------------------
local ID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -44.180, y = -24.518, z =  511.993 }
}

entity.phList =
{
    [ID.mob.OKYUPETE - 8] = ID.mob.OKYUPETE,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 446)
    xi.magian.onMobDeath(mob, player, optParams, set{ 221, 649, 715, 946 })
end

return entity
