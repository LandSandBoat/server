-----------------------------------
-- Judgment Bolt
-- Family: Avatar (Rumuh)
-- Description: Deals Thunder elemental damage to enemies within area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl() + 2
    params.fTP             = { 9, 9, 9 }
    params.element         = xi.element.THUNDER
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.THUNDER
    params.shadowBehavior  = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.dStatMultiplier = 1.5

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
