-----------------------------------
-- Colossal_Blow
-- Deals damage to a single target.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local currentHP = target:getHP()
    -- remove all by 5%
    local damage = 0

    -- if have more hp then 30%, then reduce to 5%
    if target:getHPP() > 30 then
        damage = currentHP * .95
    else
        -- else you die
        damage = currentHP
    end

    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    mob:resetEnmity(target)
    return dmg
end

return mobskillObject
