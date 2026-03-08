-----------------------------------
-- Impact Stream
-- Family: Aerns
-- Description: Deals unaspected magic damage. Additional Effect: Defense Down, Stun
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl()
    params.fTP            = { 2, 2, 2 }
    params.element        = xi.element.NONE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.NONE
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        -- TODO: Turn this into a function that can be used everywhere.
        -- Defense down power scales with TP
        -- 1000-1999 = 50
        -- 2000-2999 = 55
        -- 3000      = 60
        local power = 50 + 5 * math.floor((skill:getTP() - 1000) / 1000)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, power, 0, 60) -- TODO: Capture duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4)
    end

    return info.damage
end

return mobskillObject
