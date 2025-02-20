-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Plague Chigoe
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 75)
    mob:setMod(xi.mod.MAIN_DMG_RATING, -50)
    mob:hideName(false)
    mob:setUntargetable(false)
end

entity.onAdditionalEffect = function(mob, target, damage)
    if math.random(100) <= 5 and not target:hasStatusEffect(xi.effect.PLAGUE) then
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PLAGUE, { chance = 100 })
    else
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.MP_DRAIN, { power = target:getMaxMP() * 0.01, chance = 100 })
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
