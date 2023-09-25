-----------------------------------
-- Area: Monarch Linn
-- Mob: Hotupuku
-- ENM: Bugard in the Clouds
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    if mob:getHPP() < 30 then
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE, { chance = 50, power = math.random(70, 80) })
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Does not repeat 2 hour abilities
    if skill:getID() == 382 or skill:getID() == 383 or skill:getID() == 385 then
        if mob:getLocalVar("repeat") < 2 then
            mob:setLocalVar("repeat", mob:getLocalVar("repeat") + 1)
            local id = skill:getID()

            if mob:checkDistance(target) < 7.0 then
                mob:queue(3000, function(mobArg)
                    mobArg:useMobAbility(id)
                end)
            end
        end
    end
    if skill:getID() == 694 then
        mob:setLocalVar("invincible", 1)
    end
end

entity.onMobFight = function(mob)
    if mob:getLocalVar("repeat") == 2 then
        mob:timer(10000, function(mobArg)
            mobArg:setLocalVar("repeat", 0)
        end)
    end

    if mob:getLocalVar("invincible") == 1 then
        mob:setMod(xi.mod.DOUBLE_ATTACK, 100)
    end

    if mob:getHPP() < 25 and mob:getLocalVar("strikesControl") == 0 then
        mob:setLocalVar("strikesControl", 1)
        mob:useMobAbility(688)
    end
end

entity.onMobDeath = function(mob)
end

return entity
