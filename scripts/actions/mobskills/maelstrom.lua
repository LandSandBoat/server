-----------------------------------
-- Maelstrom
-- Family: Sea Monk
-- Description: Deals Water damage to enemies within range. Additional Effect: STR Down.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 2.00, 2.50, 3.00 }
    params.element        = xi.element.WATER
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.WATER
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local power    = 10
        local duration = 180 -- TODO: Capture duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, power, 9, duration)
    end

    return info.damage
end

return mobskillObject
