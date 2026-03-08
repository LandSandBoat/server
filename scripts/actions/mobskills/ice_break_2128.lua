-----------------------------------
-- Ice Break (Hrungnir)
-- Family: Golems
-- Description: Deals ice damage to enemies within range. Additional Effect: Bind
-- Note: Shows as a regular attack
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl() + 2
    params.fTP             = { 2.0, 2.0, 2.0 }
    params.element         = xi.element.ICE
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.ICE
    params.shadowBehavior  = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.dStatMultiplier = 1
    params.primaryMessage  = xi.msg.basic.HIT_DMG

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType, { breakBind = false })

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, xi.mobskills.calculateDuration(skill:getTP(), 120, 180))
    end

    return info.damage
end

return mobskillObject
