-----------------------------------
-- Colossal_Blow
-- Deals damage to a single target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local currentHP = target:getHP()
    local damage    = currentHP

    -- if we have more than 30% hp, reduce to 5%
    if target:getHPP() > 30 then
        damage = currentHP * .95
    end

    local info =
    {
        damage
    }

    local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    mob:resetEnmity(target)
    return dmg
end

return mobskillObject
