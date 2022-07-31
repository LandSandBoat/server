-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Purson
-- KSNM30: The Scarlet King
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 40)
end

entity.onMobEngaged = function(mob)
    mob:setLocalVar("timer", os.time() + 10)
    mob:useMobAbility(800)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    mob:setLocalVar("skill_tp", mob:getTP())
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar("timer") < os.time() then
        mob:useMobAbility(695)
        mob:setLocalVar("timer", os.time() + 45)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 695 then
        mob:addTP(mob:getLocalVar("skill_tp"))
        mob:setLocalVar("skill_tp", 0)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
