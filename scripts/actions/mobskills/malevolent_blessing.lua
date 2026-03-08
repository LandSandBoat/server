-----------------------------------
-- Malevolent Blessing
-- Family: Promathia
-- Description: Deals conal aoe Dark damage in front of mob. Additional Effect: Curse
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Verify if Physical/Magical skill
    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 3.0, 3.0, 3.0 }
    params.element        = xi.element.DARK -- TODO: Capture element.
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_2 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture power/duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, 35, 0, 45)
    end

    return info.damage
end

return mobskillObject
