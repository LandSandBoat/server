-----------------------------------
-- Blastbomb
-- Family: Orc Warmachine
-- Description: Deals Fire damage in an area of effect. Additional Effect: Bind
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getMainLvl() + 2
    params.fTP              = { 3.00, 3.00, 3.00 }
    params.element          = xi.element.FIRE
    params.attackType       = xi.attackType.MAGICAL
    params.damageType       = xi.damageType.FIRE
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType, { breakBind = false })

        local duration = xi.mobskills.calculateDuration(skill:getTP(), 30, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, duration)
    end

    return info.damage
end

return mobskillObject
