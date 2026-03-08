-----------------------------------
-- Stone Meeble Warble
-- Family: Meebles
-- Description: AOE Earth Elemental damage, inflicts Petrification and Rasp (50 HP/tick).
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 16.00, 16.00, 16.00 } -- TODO: Capture fTPs
    params.element        = xi.element.EARTH
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.EARTH
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture power/durations
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 30, 0, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.RASP, 50, 3, 60)
    end

    return info.damage
end

return mobskillObject
