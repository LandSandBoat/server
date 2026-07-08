-----------------------------------
-- Area: Jugner Forest
--   NM: Panzer Percival
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  239.541, y = -0.365, z =  559.722 }
}

entity.phList =
{
    [ID.mob.PANZER_PERCIVAL[1] - 4] = ID.mob.PANZER_PERCIVAL[1], -- Confirmed on retail
    [ID.mob.PANZER_PERCIVAL[2] - 5] = ID.mob.PANZER_PERCIVAL[2], -- Needs retail confirmation (northwest)
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 157)
    xi.magian.onMobDeath(mob, player, optParams, set{ 282 })
end

return entity
