-----------------------------------
-- Stomping
-- Family: Dhalmel
-- Description: Deals heavy damage to a single target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 1
    params.fTP              = { 1.5, 1.5, 1.5 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.SLASHING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier = { 1.5, 1.5, 1.5 }

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.STUN, power = 1, duration = math.randomInt(5, 10) },
        }

        xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, { messageBypass = true })
    end

    return info.damage
end

return mobskillObject
