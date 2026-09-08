-----------------------------------
-- Wing Thrust
-- Family: Aern
-- Description: Delivers a fourfold attack. Additional Effect: Slow
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 4
    params.fTP              = { 0.5, 0.5, 0.5 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.SLASHING -- TODO: Capture damageType
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_4
    -- params.accuracyModifier = { 0, 0, 0 } -- TODO: Accuracy modifier. Reported to be inaccurate

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.SLOW, power = 3437, duration = math.randomInt(30, 60), tier = 1 }, -- TODO: Duration random, resisted or scale with TP?
        }

        xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, { messageBypass = true })
    end

    return info.damage
end

return mobskillObject
