-----------------------------------
--  Sub-Zero Smash
--
--  Description: Additional Effect: Paralysis. Damage varies with TP.
--  Type: Physical (blunt)
--  Range: Cone (5' yalms)
--  Notes: This spell should be used anytime the target is behind the mob.
--         However the online documentation suggests that this spell can
--         still be used anytime. As a result, any other Ruszor spells
--         should not trigger if the target is behind the mob.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1  -- Hits once, despite the animation looking like it hits twice.
    local dmgmod = 1
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 10, 0, 100)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
