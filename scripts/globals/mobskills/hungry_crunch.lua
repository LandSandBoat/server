-----------------------------------
-- Hungry Crunch
-- Drains HP, TP, and food
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = math.random(0, 151) + 150
    local dmg = xi.mobskills.mobFinalAdjustments(power, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        local tpDrain = math.random(100, 200)
        target:addTP(-tpDrain)
        mob:addTP(tpDrain)

        if target:hasStatusEffect(xi.effect.FOOD) then
            target:delStatusEffect(xi.effect.FOOD)
        elseif target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
            target:delStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
        end

        skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))
    end

    return dmg
end

return mobskillObject
