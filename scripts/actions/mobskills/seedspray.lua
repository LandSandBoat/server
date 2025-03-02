-----------------------------------
-- Seedspray
-- Family: Rafflesia
-- Description: Single-target damage and Defense Down.
-- Type: Physical
-- Utsusemi/Blink absorb: Absorbed by 3 shadows.
-- Range: 11.5 yalms
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local ftp    = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 8, 0, 120)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    return dmg
end

return mobskillObject
