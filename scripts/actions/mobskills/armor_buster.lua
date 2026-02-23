-----------------------------------
-- Armor Buster
-- Family: Ultima
-- Description: Deals Light damage to players in an area of effect. Additional Effect: Weight
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getLocalVar('citadelBuster') == 0 then -- TODO: Handle in mobscript?
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 7.5, 7.5, 7.5 } -- TODO: Capture fTPs
    params.element        = xi.element.LIGHT
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.LIGHT
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 20, 0, 45) -- TODO: Capture power/duration
    end

    return info.damage
end

return mobskillObject
