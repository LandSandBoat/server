-----------------------------------
-- Divine Malison
-- Used by Shantotto in ASA-13 "Project: Shantottofication".
-- Observed on retail: a single hit on one target with no status line.
-- The area of effect and the Stun, Silence, Plague and Dia come from the JP wiki. BG Wiki lists Slow in place of Dia.
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
    params.fTP            = { 1.5, 1.5, 1.5 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture needed, the powers and durations are guesses. Dia uses the Dia II values.
        local effectTable =
        {
            [1] = { effectId = xi.effect.STUN,    power = 1, duration = 5                                      },
            [2] = { effectId = xi.effect.SILENCE, power = 1, duration = 60                                     },
            [3] = { effectId = xi.effect.PLAGUE,  power = 5, duration = 60, tick = 3                           },
            [4] = { effectId = xi.effect.DIA,     power = 2, duration = 60, tick = 3, subPower = 15, tier = 3 },
        }

        xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, { messageBypass = true })
    end

    return info.damage
end

return mobskillObject
