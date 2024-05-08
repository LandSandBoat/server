-----------------------------------
-- Area: Grauberg [S]
--   NM: Sarcopsylla
-- https://www.bg-wiki.com/ffxi/Sarcopsylla
-----------------------------------
mixins = { require('scripts/mixins/families/chigoe_nm') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.IMMUNITY.IMMUNITY_LIGHT_SLEEP)
    mob:addImmunity(xi.IMMUNITY.IMMUNITY_DARK_SLEEP)
    mob:addImmunity(xi.IMMUNITY.IMMUNITY_GRAVITY)
    mob:addImmunity(xi.IMMUNITY.IMMUNITY_BIND)
    mob:addImmunity(xi.IMMUNITY.IMMUNITY_SILENCE)
    mob:addImmunity(xi.IMMUNITY.IMMUNITY_PETRIFY)

    mob:setMod(xi.mod.TRIPLE_ATTACK, 100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE, { power = math.random(25, 30) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 502)
end

return entity
