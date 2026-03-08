-----------------------------------
-- Thunder Break
-- Family: Golems (Hrungnir)
-- Description: Channels the power of Thunder toward targets in an area of effect. Additional Effect: Stun
-- Note: Shows as a regular attack, used by Hrungnir.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 1.00, 1.00, 1.00 } -- TODO: Capture fTP Scaling
    params.element        = xi.element.THUNDER
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.THUNDER
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.primaryMessage = xi.msg.basic.HIT_DMG

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

         -- TODO: Capture stun duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4)
    end

    return info.damage
end

return mobskillObject
