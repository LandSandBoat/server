-----------------------------------
-- Tourbillion
-- Family: Khimaira
-- Description: Delivers an area attack. Additional Effect: Defense Down
-- Note: Can only be used with wings up
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return mob:getAnimationSub() == 0 and 0 or 1 -- Wings up
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 3 -- TODO: Capture numHits
    params.fTP            = { 1.5, 1.5, 1.5 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior
    -- TODO: Confirm AoE type (On mob vs on target. Radial or conal)

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture power/duration
        local duration = xi.mobskills.calculateDuration(mob:getTP(), 20, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 20, 0, duration)
    end

    return info.damage
end

return mobskillObject
