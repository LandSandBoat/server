-----------------------------------
-- Ore Toss
-- Family: Quadav
-- Description: Deals high damage in a ranged attack.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 2.0, 2.0, 2.0 }
    params.attackType     = xi.attackType.RANGED
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.skipParry      = true
    params.skipGuard      = true
    params.skipBlock      = true

    local info = xi.mobskills.mobRangedMove(mob, target, skill, action, params)

    -- Distance-based damage scaling: 1x at 1 yalm, 3x at 10 yalms
    -- TODO: Determine max distance of skill
    local distance           = mob:checkDistance(target)
    local distanceMultiplier = utils.clamp(1 + (distance - 1) * 2 / 9, 1, 3)
    info.damage = info.damage * distanceMultiplier

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
