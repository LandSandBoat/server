-----------------------------------
--  Impale
--
--  Description: Deals damage to a single target. Additional effect: Paralysis (NM version AE applies a strong poison effect and resets enmity on target)
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow (NM version ignores shadows)
--  Range: Melee
--  Notes:
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local attmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 1.5, 2, 0, attmod)
    local shadows = info.hitslanded

    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        shadows = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
        typeEffect = xi.effect.POISON

        if not skill:hasMissMsg() then
            mob:resetEnmity(target)
        end
    end

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, shadows)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 20, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    end

    return dmg
end

return mobskillObject
