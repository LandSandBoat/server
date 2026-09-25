-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--   NM: Shii
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.SHII - 1] = ID.mob.SHII, -- Confirmed on retail
    [ID.mob.SHII - 5]  = ID.mob.SHII, -- Confirmed on retail
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('killed', 0)
    mob:setMod(xi.mod.REGEN, 20) -- "also has an Auto Regen of medium strength" (guessing 20)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1) -- "has an Additional Effect: Terror in melee attacks"
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TERROR)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        mob:setLocalVar('killed', 1)
    end

    xi.hunts.checkHunt(mob, player, 179)
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
