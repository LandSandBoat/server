-----------------------------------
-- Circle of Flames
-- Family: Clusters
-- Description: Deals Fire damage to targets in an area of effect. Additional Effect: Weight
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 2 then -- 1 bomb left
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- Determine number of bombs exploded based on animation sub
    -- 3/4 or 11/12 = 3 bombs remaining (0 exploded)
    -- 5 or 13 = 2 bombs remaining (1 exploded)

    -- TODO: Standardize spawn animation subs for clusters.
    local animation     = mob:getAnimationSub()
    local bombsExploded = 0

    if animation == 5 or animation == 13 then
        bombsExploded = 1
    elseif animation == 6 or animation == 14 then
        bombsExploded = 2
    end

    local bombBonusDamage = 25 * bombsExploded

    params.baseDamage     = mob:getMainLvl() + 2
    params.additiveDamage = { bombBonusDamage, bombBonusDamage, bombBonusDamage }
    params.fTP            = { 0.5, 0.5, 0.5 }
    params.element        = xi.element.FIRE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.FIRE
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 20, 0, 120)
    end

    return info.damage
end

return mobskillObject
