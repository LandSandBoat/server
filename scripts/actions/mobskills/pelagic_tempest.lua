-----------------------------------
--  Pelagic Tempest
--
--  Description: Delivers an area attack that inflicts Shock and Terror.
--  Type: Physical?
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 10' cone
--  Notes: Used by Murex affiliated with lightning element. Shock effect is fairly strong (28/tick).
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local numhits = 1
    local accmod = 2
    local ftp    = 3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SHOCK, 28, 3, 180)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.TERROR, 1, 0, 180)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
