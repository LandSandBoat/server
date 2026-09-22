-----------------------------------
-- Blindside Barrage
-- Family: Lesser Bird
-- Description: Deals physical damage to a single target. Additional Effect: INT Down, MND Down
-- Notes: Notorious Monster/Nightmare version deals damage in a 10 yalm area of effect around target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 1.0, 1.0, 1.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- Upper limit needs to be captured

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local power = 3 + math.floor(mob:getMainLvl() / 5)

        -- Note: Status effects do not decay.
        local effectTable =
        {
            [1] = { effectId = xi.effect.MND_DOWN, power = power, duration = 90 },
            [2] = { effectId = xi.effect.INT_DOWN, power = power, duration = 90 },
        }

        xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, { messageBypass = true })
    end

    return info.damage
end

return mobskillObject
