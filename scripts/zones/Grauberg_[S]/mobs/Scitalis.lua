-----------------------------------
-- Area: Grauberg [S]
--   NM: Scitalis
-- https://www.bg-wiki.com/ffxi/Scitalis
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMod(xi.mod.DOUBLE_ATTACK, 50)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    -- Captures show unresisted damage between 120 and 200. TODO find what causes full power AE to vary so greatly
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO, { power = math.random(165, 190) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 503)
end

return entity
