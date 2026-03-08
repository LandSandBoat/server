-----------------------------------
-- Mix: Dark Potion - Deals 666 damage to a single enemy.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local darkpot = 666
    local info    =
    {
        damage = darkpot
    }

    local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.NONE, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.NONE, xi.damageType.NONE)

    return dmg
end

return mobskillObject
