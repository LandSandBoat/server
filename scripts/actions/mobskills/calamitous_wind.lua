-----------------------------------
-- Calamitous Wind
-- Family: Amphipteres
-- Description: Deals Wind damage to targets in range. Additional Effect: Full Dispel, Knockback
-- Notes: Used by Zirnitra, Turul, and Amhuluk under 50%
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getHPP() >= 50 then -- TODO: Migrate to mob script?
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 4, 4, 4 }
    params.element        = xi.element.WIND
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.WIND
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        target:dispelAllStatusEffect(bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))
    end

    return info.damage
end

return mobskillObject
