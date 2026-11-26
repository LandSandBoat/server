-----------------------------------
-- Salvation Scythe
-- Used by D. Shantotto in ASA-13 "Project: Shantottofication".
-- Observed on retail: a single physical hit on one target.
-- The area of effect and the Poison, Paralysis, Slow and Bio come from the JP wiki. BG Wiki lists only Poison and Paralysis.
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
    params.fTP            = { 2.0, 2.0, 2.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture needed, the powers and durations are guesses. Bio uses the Bio II values.
        local effectTable =
        {
            [1] = { effectId = xi.effect.POISON,    power = 20,   duration = 60, tick = 3                           },
            [2] = { effectId = xi.effect.PARALYSIS, power = 20,   duration = 60                                     },
            [3] = { effectId = xi.effect.SLOW,      power = 2000, duration = 60, tier = 1                           },
            [4] = { effectId = xi.effect.BIO,       power = 8,    duration = 60, tick = 3, subPower = 15, tier = 4 },
        }

        xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, { messageBypass = true })
    end

    return info.damage
end

return mobskillObject
