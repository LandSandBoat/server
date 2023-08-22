-----------------------------------
-- Toxic Pick
-- Deals damage to a single target. Additional effect: Poison, Plague, Gravity effect on target
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local power = math.ceil(mob:getMainLvl() / 5)
    local poisonPower

    if mob:getPool() == 1532 then
        poisonPower = 30
    else
        poisonPower = math.ceil(mob:getMainLvl() / 5)
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, poisonPower, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, power, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 1, 0, 60)

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end

return mobskillObject
