-----------------------------------
-- Dragon Kick
-- Family: Humanoid Hand to Hand Weaponskill
-- Description:
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1 -- TODO: Capture numHits
    params.fTP            = { 3.0, 3.0, 3.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT -- TODO: Should this be xi.damageType.HTH?
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1 -- TODO: Capture shadowBehavior
    -- TODO: Does Kick Attack modifiers apply to this?

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
