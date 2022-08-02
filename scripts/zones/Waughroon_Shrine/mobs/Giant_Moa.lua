-----------------------------------
-- Area: Balga's Dais
--  Mob: Giant Moa
-- KSNM: Moa Constrictors
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 50)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local x = math.random()
    if x > 0.6 then
        return 1335
    elseif x > 0.2 then
        return 1333
    elseif x > 0.1 then
        return 406
    else
        return 411
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1333 then
        mob:queue(0, function(mobArg)
            if target:isAlive() and target:checkDistance() < 10 then
                mobArg:useMobAbility(1334)
            end
        end)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
