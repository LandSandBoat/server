-----------------------------------
-- Area: Rolanberry Fields
--   NM: Black Triple Stars
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS]
-----------------------------------
---@type TMobEntity
local entity = {}

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
    -- Only a kill starts the lottery cooldown. A natural despawn at the end of
    -- the spawn window skips it, so placeholders can pop the NM again the same
    -- or next night.
    if mob:getLocalVar('killed') == 0 then
        mob:setLocalVar('doNotInvokeCooldown', 1)
    end
end

return entity
