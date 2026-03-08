-----------------------------------
-- Hellfire Arrow
-- Family: Yztarg (Red)
-- Description: Deals Fire damage to targets in front of mob. Additional Effect: Burn
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 2.7, 2.7, 2.7 } -- TODO: Capture fTPs
    params.element        = xi.element.FIRE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.FIRE
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

         -- TODO: Capture power/duration
        local power  = math.random(10, 30)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, power, 3, 60)
    end

    return info.damage
end

return mobskillObject
