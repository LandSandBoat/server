-----------------------------------
-- Zephyr Arrow
-- Family: Pixie
-- Description: Deals a ranged attack to target. Additional Effect: Bind, Knockback
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Ranged or Physical skill?
    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 5.0, 5.0, 5.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType, { breakBind = false })

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 120) -- TODO: Capture duration
    end

    return info.damage
end

return mobskillObject
