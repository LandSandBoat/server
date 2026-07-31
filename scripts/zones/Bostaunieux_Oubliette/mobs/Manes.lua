-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--   NM: Manes
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -60.400, y =  17.000, z = -138.000 }
}

entity.phList =
{
    [ID.mob.MANES - 1] = ID.mob.MANES, -- Confirmed on retail
    [ID.mob.MANES + 6] = ID.mob.MANES, -- Confirmed on retail
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('killed', 0)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TERROR)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        mob:setLocalVar('killed', 1)
    end

    xi.hunts.checkHunt(mob, player, 180)
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
