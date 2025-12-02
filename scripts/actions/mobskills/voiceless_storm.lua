-----------------------------------
--  Voiceless Storm
--  Description: AOE Damage, Silence, strips Utsusemi (xi.mobskills.shadowBehavior.WIPE_SHADOWS)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- TODO: 1 + dINT to damage
    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.element.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SILENCE, 1, 0, 120)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return damage
end

return mobskillObject
