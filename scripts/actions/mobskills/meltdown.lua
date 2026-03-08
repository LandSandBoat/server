-----------------------------------
-- Meltdown
-- Family: Dolls
-- Description: Doll self destructs and deals Light damage to targets in range.
-- Note: Dolls will begin an animation sequence that changes their animationSub() before actually using this skill.
-- This sequence may not be tied to normal TP usage.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isMobType(xi.mobType.NOTORIOUS) then -- TODO: Set skill lists instead of conditional.
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = skill:getMobHP() / 2
    params.fTP            = { 1, 1, 1 }
    params.element        = xi.element.LIGHT
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.LIGHT
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

mobskillObject.onMobSkillFinalize = function(mob, skill)
    mob:setHP(0)
end

return mobskillObject
