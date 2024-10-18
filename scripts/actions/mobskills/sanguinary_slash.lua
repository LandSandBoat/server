-----------------------------------
-- Name: Sanguinary Slash
-- Description: Knockback and Max HP Down.
-- Type: Physical (Slashing)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local dmgmod = 1.5
    local duration = math.random(15, 120)

    -- Corrected mobPhysicalMove function call
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2)
    local damage = xi.mobskills.mobFinalAdjustments(info.damage, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_HP_DOWN, 10, 0, duration)

    target:takeDamage(damage, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    return damage
end

return mobskillObject
