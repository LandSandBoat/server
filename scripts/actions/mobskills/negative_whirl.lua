-----------------------------------
--  Negative Whirl
--
--  Description: Slow Wipes shadows
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 10' cone
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

-- Element table based on Thinker model IDs and animation subs
local elementTable =
{
    [1123] =
    {
        [14] = { element = xi.element.WATER, damageType = xi.damageType.WATER },
        [13] = { element = xi.element.DARK, damageType = xi.damageType.DARK },
    },
    [1124] =
    {
        [14] = { element = xi.element.EARTH, damageType = xi.damageType.EARTH },
        [13] = { element = xi.element.THUNDER, damageType = xi.damageType.THUNDER },
    },
    [1126] =
    {
        [14] = { element = xi.element.FIRE, damageType = xi.damageType.FIRE },
        [13] = { element = xi.element.LIGHT, damageType = xi.damageType.LIGHT },
    },
    [1127] =
    {
        [13] = { element = xi.element.ICE, damageType = xi.damageType.ICE },
        [14] = { element = xi.element.WIND, damageType = xi.damageType.WIND },
    },
}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getMainLvl() * 2

    if mob:isNM() then
        damage = mob:getMainLvl() * 3
    end

    -- Determine element based on model ID and animation sub
    local modelId = mob:getModelId()
    local animationSub = mob:getAnimationSub()
    local element = xi.element.NONE
    local dmgType = xi.damageType.ELEMENTAL

    if elementTable[modelId] and elementTable[modelId][animationSub] then
        element = elementTable[modelId][animationSub].element
        dmgType = elementTable[modelId][animationSub].damageType
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, element, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, dmgType, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, dmgType)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 8500, 0, 60)

    return damage
end

return mobskillObject
