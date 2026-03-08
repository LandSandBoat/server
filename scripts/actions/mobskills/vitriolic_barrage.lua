-----------------------------------
-- Vitriolic Barrage
-- Family: Yovra
-- Description: Deals unaspected? magic damage to targets in range. Additional Effect: Poison
-- Notes: Affected by MDEF stat.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage           = 1000 / skill:getTotalTargets()
    params.fTP                  = { 1.00, 1.00, 1.00 }
    params.element              = xi.element.NONE -- TODO: Verify whether unaspected or elemental
    params.attackType           = xi.attackType.MAGICAL
    params.damageType           = xi.damageType.NONE
    params.shadowBehavior       = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    -- https://youtu.be/DgQrZQJEqDY?t=409
    -- Looks like it bypasses MDT(Shell) but is reduced by MDEF
    params.skipDamageAdjustment = true

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 18, 3, 180)
    end

    return info.damage
end

return mobskillObject
