-----------------------------------
-- Area: Bibiki Bay
-- NM: Dalham
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.WATER_ABSORB, 100)
    mob:setMod(xi.mod.SLEEPRES, 90)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("swings", 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER, { chance = 100 })
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 626 then
        mob:setLocalVar("swings", mob:getLocalVar("swings") + 1)
        mob:setMobMod(xi.mobMod.MULTI_HIT, mob:getLocalVar("swings"))
        mob:setTP(mob:getLocalVar("mobTP"))
    end
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 70 and mob:getLocalVar("hpControl1") == 0 then
        mob:setLocalVar("hpControl1", 1)
        mob:setLocalVar("mobTP", mob:getTP())
        mob:useMobAbility(626)

    elseif mob:getHPP() < 40 and mob:getLocalVar("hpControl2") == 0 then
        mob:setLocalVar("hpControl2", 1)
        mob:setLocalVar("mobTP", mob:getTP())
        mob:useMobAbility(626)

    elseif mob:getHPP() < 15 and mob:getLocalVar("hpControl3") == 0 then
        mob:setLocalVar("hpControl3", 1)
        mob:setLocalVar("mobTP", mob:getTP())
        mob:useMobAbility(626)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
