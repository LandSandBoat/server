-----------------------------------
-- Area: Spire of Dem
-- Mob: Ingester
-- ENM: You Are What You Eat
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.MP_DRAIN)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    mob:setLocalVar("skill_tp", mob:getTP())
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 755 then
        mob:addTP(mob:getLocalVar("skill_tp"))
        mob:setLocalVar("skill_tp", 0)
    end
end

entity.onMobFight = function(mob, target)
    local id = mob:getID()

    for i = 1, 4 do
        if not GetMobByID(id+i):isSpawned() then
            mob:setLocalVar("spawnHP", (i * 20))
        end
    end

    local spawnHP = mob:getLocalVar("spawnHP")

    if mob:getLocalVar("timer") < os.time() and mob:getHPP() <= spawnHP then
        mob:setLocalVar("timer", os.time() + 50)
        mob:useMobAbility(755)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    local id = mob:getID()
    if isKiller then
        for i = 1, 4 do
            if GetMobByID(id+i):isAlive() then
                GetMobByID(id+i):setHP(0)
            end
        end
    end
end

return entity
