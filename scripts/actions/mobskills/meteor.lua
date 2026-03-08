-----------------------------------
-- Final Meteor
-- Family: Behemoth (Chlevnik)
-- Description: Extreme non-elemental damage.
-- Notes: Used by Chlevnik upon death.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl()
    params.fTP            = { 32, 32, 32 }
    params.element        = xi.element.NONE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.NONE
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    -- Animation change happens after mobskill finishes.
    -- Animation: Chlevnik falls but calls in a final meteor barrage, then dies.
    skill:setFinalAnimationSub(1)

    return info.damage
end

return mobskillObject
