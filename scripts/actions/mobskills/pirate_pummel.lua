-----------------------------------
-- Pirate Pummel
-- Family: Humanoid (Lion)
-- Description: Deals damage to a target. Additional Effect: Burn
-- Skillchain Properties: Fusion/Impaction
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 2 -- TODO: Capture numHits
    params.fTP            = { 0.3, 0.3, 0.3 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_2 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, 1, 0, 20) -- TODO: Capture power/duration
    end

    return info.damage
end

return mobskillObject
