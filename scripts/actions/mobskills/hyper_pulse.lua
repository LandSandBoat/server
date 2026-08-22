-----------------------------------
-- Hyper Pulse
-- Family: Omega
-- Description: Deals damage. Additional Effect: Bind, Gravity
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 4.5, 4.5, 4.5 }
    params.element        = xi.element.NONE -- TODO: Capture element.
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.ELEMENTAL
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType, { breakBind = false })

        local effectTable =
        {
            [1] = { effectId = xi.effect.BIND,   power = 1,  duration = 15 },
            [2] = { effectId = xi.effect.WEIGHT, power = 25, duration = 60 },
        }

        xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, { messageBypass = true })
    end

    return info.damage
end

return mobskillObject
