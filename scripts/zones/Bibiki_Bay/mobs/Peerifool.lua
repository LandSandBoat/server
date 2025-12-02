-----------------------------------
-- Area: Bibiki Bay
--  Mob: Peerifool
-- Note: NM for quest One Good Deed?
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
    mob:addStatusEffectEx(xi.effect.STUN, xi.effect.STUN, 0, 0, 3, 0, 0, 0, xi.effectFlag.NO_LOSS_MESSAGE, true) -- Holds the mobs for a few seconds until they move to attack the player
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLEEP)
end

return entity
