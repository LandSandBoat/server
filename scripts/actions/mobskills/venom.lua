-----------------------------------
-- Venom
-- Family: Fly
-- Description: Deals Water damage in a fan shaped area. Additional Effect: Poison
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 1.50, 1.50, 1.50 }
    params.element        = xi.element.WATER
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.WATER
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Jugpet differences

        -- TODO: Dynamis - Nightmare Fly

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 1, 3, 60) -- TODO: Capture duration
    end

    return info.damage
end

return mobskillObject
