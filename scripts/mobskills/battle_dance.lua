-----------------------------------
--  Battle Dance
--  Description: Delivers an area attack. Additional effect: DEX Down. Duration of effect varies with TP.
--  Type: Physical (Slashing)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    local typeEffect = xi.effect.DEX_DOWN

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 10, 3, 120)

    return dmg
end

return mobskillObject
