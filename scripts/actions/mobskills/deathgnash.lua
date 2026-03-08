-----------------------------------
-- Deathgnash
-- Description: Chomps on a single target, reducing HP to one and resets enmity.
-- Type: Physical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local damage = target:getHP() - 1
    local info   =
    {
        damage = damage
    }

    damage = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(damage, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    mob:resetEnmity(target)

    return damage
end

return mobskillObject
