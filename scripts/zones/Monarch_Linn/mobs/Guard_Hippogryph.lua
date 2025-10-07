-----------------------------------
-- Area: Monarch Linn
-- Mob: Guard Hippogryph
-- ENM: Beloved of the Atlantes
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.UFASTCAST, 80)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
end

entity.onMobFight = function(mob, target)
    local mobID = mob:getID()
    local watcher = GetMobByID(mobID - 1)

    if watcher and watcher:getHPP() <= 10 then
        mob:setMod(xi.mod.REGAIN, 1000) -- Enrages when Watch Hippogryph is at 10% HP
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { chance = 20, power = math.random(50, 60) })
end

return entity
