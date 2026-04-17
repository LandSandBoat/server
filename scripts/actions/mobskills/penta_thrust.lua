-----------------------------------
-- Penta Thrust
-- Family: Humanoid Polearm Weaponskill
-- Description: Delivers a five-hit attack to a single target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 5
    params.fTP              = { 1.0, 1.0, 1.0 } -- TODO: Capture fTPs
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.PIERCING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_5
    -- params.accuracyModifier = { 0, 0, 0 }
    -- TODO: Accuracy modifier
    -- Old ACC line: 0.8 + 0.1 * math.floor((tp - 1000) / 1000)
    -- Assuming this was attempting to modify the hit rate but we now use raw accuracy values rather than directly modifying the hit rate.

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
