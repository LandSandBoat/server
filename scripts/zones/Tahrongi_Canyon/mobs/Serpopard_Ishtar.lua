-----------------------------------
-- Area: Tahrongi Canyon
--   NM: Serpopard Ishtar
-----------------------------------
local ID = zones[xi.zone.TAHRONGI_CANYON]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -0.048, y =  21.041, z =  266.381 }
}

entity.phList =
{
    [ID.mob.SERPOPARD_ISHTAR[1] - 3] = ID.mob.SERPOPARD_ISHTAR[1], -- Confirmed on retail
    [ID.mob.SERPOPARD_ISHTAR[2] - 4] = ID.mob.SERPOPARD_ISHTAR[2], -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 257)
    xi.magian.onMobDeath(mob, player, optParams, set{ 150 })
end

return entity
