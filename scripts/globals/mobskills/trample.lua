-----------------------------------
--  Trample
--  Family: Bahamut
--  Description: Deals physical damage to enemies in an area of effect. Additional effect: Knockback + Bind
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range:
--  Notes:
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BIND
    local duration = math.random(40, 60)

    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local ftp100 = 1.5
    local ftp200 = 1.75
    local ftp300 = 2.0

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, ftp100, ftp200, ftp300)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded * math.random(2, 3))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, duration)

    return dmg
end

return mobskillObject
