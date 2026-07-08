-----------------------------------
-- Oisoya
-- Family: Humanoid (Tenzen)
-- Description: Unique ranged weaponskill used by Tenzen during The Warrior's Path. Also used by Trust: Tenzen II.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        (mob:getAnimationSub() == 5 or
        mob:getAnimationSub() == 6) and
        mob:getLocalVar('[Tenzen]ShouldOisoya') == 1 -- TODO: Move to mob script
    then -- if tenzen is in bow mode
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 1
    params.fTP              = { 5.5, 5.5, 5.5 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.PIERCING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier = { 2.75, 2.75, 2.75 }
    params.skipParry        = true
    params.skipGuard        = true
    params.skipBlock        = true
    -- TODO: Accuracy modifier

    local info = xi.mobskills.mobRangedMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
