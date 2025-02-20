-----------------------------------
--  Zephyr Arrow
--  Description: Deals a ranged attack to target. Additional effect: Knockback and Bind
--  Type: Ranged
--  Utsusemi/Blink absorb: Ignores Utsusemi
--  Range: Unknown
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 4
    local ftp    = 5 -- fTP and fTP scaling unknown. TODO: capture ftp

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING, { breakBind = false })

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 120)

    return dmg
end

return mobskillObject
