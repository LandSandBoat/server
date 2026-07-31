-----------------------------------
-- Area: Rolanberry Fields
--   NM: Black Triple Stars
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  76.000, y = -15.000, z = -209.000 },
    { x =  56.632, y = -16.186, z = -173.715 },
    { x =  36.283, y = -15.475, z = -180.726 },
    { x =  15.184, y = -15.617, z = -190.543 },
    { x =  49.250, y = -15.435, z = -211.609 },
    { x =  66.177, y = -14.677, z = -230.888 },
    { x =  87.665, y = -15.778, z = -255.614 },
    { x =  11.649, y = -16.280, z = -126.181 },
    { x = -13.834, y = -15.616, z = -110.806 },
    { x = -15.023, y = -15.500, z = -161.697 },
    { x =   2.722, y =  15.610, z = -171.890 },
    { x =  26.949, y =  15.840, z = -169.885 },
    { x =  39.779, y = -16.000, z = -152.143 }
}

entity.phList =
{
    [ID.mob.BLACK_TRIPLE_STARS[1] - 4] = ID.mob.BLACK_TRIPLE_STARS[1], -- Confirmed on retail (north)
    [ID.mob.BLACK_TRIPLE_STARS[2] - 4] = ID.mob.BLACK_TRIPLE_STARS[2], -- Confirmed on retail (south)
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('killed', 0)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        mob:setLocalVar('killed', 1)
    end

    xi.magian.onMobDeath(mob, player, optParams, set{ 3 })
    xi.hunts.checkHunt(mob, player, 215)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)

    -- Only a kill starts the lottery cooldown. A natural despawn at the end of
    -- the spawn window skips it, so placeholders can pop the NM again the same
    -- or next night.
    if mob:getLocalVar('killed') == 0 then
        mob:setLocalVar('doNotInvokeCooldown', 1)
    end
end

return entity
