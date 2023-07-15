-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Bugboy
-- ENM: Bionic Bug
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 688 then
        mob:addStatusEffect(xi.effect.COUNTERSTANCE, 1, 0, 45)
        mob:addMod(xi.mod.UDMGMAGIC, 5000)
    end
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 75 and mob:getLocalVar("first2hr") == 0 then
        mob:setLocalVar("first2hr", 1)
        mob:useMobAbility(688)
    elseif mob:getHPP() < 50 and mob:getLocalVar("second2hr") == 0 then
        mob:setLocalVar("second2hr", 1)
        mob:useMobAbility(688)
    elseif mob:getHPP() < 25 and mob:getLocalVar("third2hr") == 0 then
        mob:setLocalVar("third2hr", 1)
        mob:useMobAbility(688)
    end
end

entity.onMobDeath = function(mob)
end

return entity
