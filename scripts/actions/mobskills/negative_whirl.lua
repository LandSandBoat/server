-----------------------------------
-- Negative Whirl
-- Family: Thinkers
-- Description: Deals Magic damage to targets in range. Additional Effect: Slow
-- Note: Element of damage varies based on individual mob. (Empty mobs have varying elements)
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

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl()
    params.fTP            = { 2, 2, 2 }
    params.element        = xi.element.NONE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.ELEMENTAL
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    if mob:isNM() then
        params.fTP = { 3, 3, 3 }
    end

    -- Determine element based on mob's model ID and animation sub
    local modelId      = mob:getModelId()
    local animationSub = mob:getAnimationSub()

    if elementTable[modelId] and elementTable[modelId][animationSub] then
        params.element    = elementTable[modelId][animationSub].element
        params.damageType = elementTable[modelId][animationSub].damageType
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 8500, 0, 60) -- TODO: Capture duration
    end

    return info.damage
end

return mobskillObject
