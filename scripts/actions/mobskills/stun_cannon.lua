-----------------------------------
-- Stun Cannon
-- Family: Omega
-- Description: Deals Thunder? damage to targets in an area of effect around the mob. Additional Effect: Paralysis
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if not target:isBehind(mob) then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 4.50, 4.50, 4.50 }
    params.element        = xi.element.THUNDER -- TODO: Capture element.
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.THUNDER
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.PARALYSIS, power = 20, duration = 60 }, -- TODO: Capture power.
        }

        xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, { messageBypass = true })
    end

    return info.damage
end

return mobskillObject
