-----------------------------------
-- Area: Grauberg [S]
--   NM: Sarcopsylla
-- https://www.bg-wiki.com/ffxi/Sarcopsylla
-----------------------------------
mixins = { require('scripts/mixins/families/chigoe_nm') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- Set immunities.
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)

    -- Set modifiers.
    mob:setMod(xi.mod.TRIPLE_ATTACK, 100)

    -- Set mob modifiers.
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE, { power = math.random(25, 30) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 502)
end

return entity
