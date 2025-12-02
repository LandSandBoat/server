-----------------------------------
-- Area: The Boyahda Tree
--   NM: Ellyllon
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.ELLYLLON - 1] = ID.mob.ELLYLLON, -- 192.54 8.532 -163.41
}

entity.spawnPoints =
{
    { x = 216.000, y = 8.129, z = -157.100 },
    { x = 209.000, y = 8.000, z = -151.000 },
    { x = 190.750, y = 8.500, z = -152.000 },
    { x = 200.000, y = 9.000, z = -167.000 },
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 357)
end

return entity
