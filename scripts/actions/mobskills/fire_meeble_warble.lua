-----------------------------------
-- Fire Meeble Warble
-- Family: Meebles
-- Description: AoE Fire Elemental damage, inflicts Plague (50 MP/tick, 300 TP/tick) and Burn (50 HP/tick).
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 9, 9, 9 } -- TODO: Capture fTP
    params.element        = xi.element.FIRE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.FIRE
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture power/duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 30, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, 50, 3, 60)
    end

    return info.damage
end

return mobskillObject
