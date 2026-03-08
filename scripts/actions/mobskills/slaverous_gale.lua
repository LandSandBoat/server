-----------------------------------
-- Slaverous Gale
-- Family: Sandworms
-- Description: Deals damage to targets in front of mob. Additional Effect: Plague, Slow
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: JP wiki says this can miss and may be a physical skill. Need more captures to confirm.
    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 5.0, 5.0, 5.0 }
    params.element        = xi.element.EARTH
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.EARTH
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, 120)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 5000, 0, 120)
    end

    return info.damage
end

return mobskillObject
