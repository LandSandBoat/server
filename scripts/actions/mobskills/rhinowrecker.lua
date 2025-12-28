-----------------------------------
-- Rhinowrecker
-- Description : Powerful physical attack to enemies in a cone. Additional Effect: Defense Down, Knockback
-- Range: Cone originating from caster.
-- TODO: Verify animation ID, skill is currently commented out in mob_skills.sql
-- Defense down power is NM specific. Abyssea only move. Needs captures.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local ftp     = 3
    local power   = 25
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.HTH, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, power, 0, 180)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.HTH)

    return dmg
end

return mobskillObject
