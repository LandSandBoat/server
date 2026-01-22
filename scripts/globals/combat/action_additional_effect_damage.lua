-----------------------------------
-- Global file for additional effects (damage)
-----------------------------------
require('scripts/globals/combat/damage_multipliers')
require('scripts/globals/combat/magic_hit_rate')
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.action = xi.combat.action or {}
-----------------------------------

local defaultsTable =
{
    [xi.element.NONE   ] = { xi.subEffect.LIGHT_DAMAGE     }, -- Like Excalibur.
    [xi.element.FIRE   ] = { xi.subEffect.FIRE_DAMAGE      },
    [xi.element.ICE    ] = { xi.subEffect.ICE_DAMAGE       },
    [xi.element.WIND   ] = { xi.subEffect.WIND_DAMAGE      },
    [xi.element.EARTH  ] = { xi.subEffect.EARTH_DAMAGE     },
    [xi.element.THUNDER] = { xi.subEffect.LIGHTNING_DAMAGE },
    [xi.element.WATER  ] = { xi.subEffect.WATER_DAMAGE     },
    [xi.element.LIGHT  ] = { xi.subEffect.LIGHT_DAMAGE     },
    [xi.element.DARK   ] = { xi.subEffect.DARKNESS_DAMAGE  },
}

-----------------------------------
-- Local functions to ensure defaults are set.
-----------------------------------
local function validateParameters(fedData)
    local params = {}

    -- Chance.
    params.chance          = fedData.chance or 100 -- Default: Always proc.

    -- Action properties.
    params.attackType      = fedData.attackType or xi.attackType.SPECIAL   -- Physical, Magical, Ranged, Breath or Special.
    params.physicalElement = fedData.physicalElement or xi.damageType.NONE -- None, H2H, Slashing, Piercing or Blunt.
    params.magicalElement  = fedData.magicalElement or xi.element.NONE     -- None, Fire, Ice, Wind, Earth, Thunder, Water, Light, Dark.

    -- Base damage parameters.
    params.basePower       = fedData.basePower or 0
    params.actorStat       = fedData.actorStat or 0
    params.targetStat      = fedData.targetStat or params.actorStat

    -- Multiplier properties.
    params.canMAB          = fedData.canMAB or false
    params.canResist       = fedData.canResist or false

    -- Animations and messaging.
    params.animation       = fedData.animation or defaultsTable[params.magicalElement][1]
    params.messageDamage   = fedData.messageDamage or xi.msg.basic.ADD_EFFECT_DMG
    params.messageHeal     = fedData.messageHeal or xi.msg.basic.ADD_EFFECT_HEAL

    return params
end

-----------------------------------
-- Global functions called from "emtity.onAdditionalEffect()"
-----------------------------------
xi.combat.action.executeAdditionalDamage = function(actor, target, fedData)
    local params = validateParameters(fedData)

    -- Early return: No proc.
    if math.random(1, 100) > params.chance then
        return 0, 0, 0
    end

    -- Additional variables.
    local isPhysical = params.attackType == xi.attackType.PHYSICAL or false
    local isMagical  = params.attackType == xi.attackType.MAGICAL or false
    local isRanged   = params.attackType == xi.attackType.RANGED or false
    local isBreath   = params.attackType == xi.attackType.BREATH or false

    -- Calculate base power.
    local damage = params.basePower + actor:getMod(params.actorStat) - target:getMod(params.targetStat)

    -- Calculate mandatory multipliers.
    local multiplierAbsorption         = xi.spells.damage.calculateAbsorption(target, params.magicalElement, params.isMagical)
    local multiplierNullification      = xi.spells.damage.calculateNullification(target, params.magicalElement, isMagical, isBreath)
    local multiplierDamageTypeSDT      = xi.combat.damage.calculateDamageAdjustment(target, isPhysical, isMagical, isRanged, isBreath)
    local multiplierPhysicalElementSDT = xi.combat.damage.physicalElementSDT(target, params.physicalElement)
    local multiplierMagicalElementSDT  = xi.combat.damage.magicalElementSDT(target, params.magicalElement)
    local multiplierElementalStaff     = xi.spells.damage.calculateElementalStaffBonus(actor, params.magicalElement)
    local multiplierElementalAffinity  = xi.spells.damage.calculateElementalAffinityBonus(actor, params.magicalElement)
    local multiplierDayWeather         = xi.spells.damage.calculateDayAndWeather(actor, params.magicalElement, false)

    -- Calculate optional multipliers.
    local multiplierMagicDiff          = params.canMAB and xi.spells.damage.calculateMagicBonusDiff(actor, target, 0, 0, params.magicalElement) or 1
    local multiplierResist             = params.canResist and xi.combat.magicHitRate.calculateResistRate(actor, target, 0, 0, xi.skillRank.A_PLUS, params.magicalElement, params.actorStat, 0, 0) or 1

    -- Calculate final damage.
    damage = math.floor(damage * multiplierAbsorption)
    damage = math.floor(damage * multiplierNullification)
    damage = math.floor(damage * multiplierDamageTypeSDT)
    damage = math.floor(damage * multiplierPhysicalElementSDT)
    damage = math.floor(damage * multiplierMagicalElementSDT)
    damage = math.floor(damage * multiplierElementalStaff)
    damage = math.floor(damage * multiplierElementalAffinity)
    damage = math.floor(damage * multiplierDayWeather)
    damage = math.floor(damage * multiplierMagicDiff)
    damage = math.floor(damage * multiplierResist)

    -- Phalanx, One for all, Stoneskin.
    if damage > 0 then
        damage = utils.clamp(utils.handlePhalanx(target, damage), 0, 99999)
        damage = utils.clamp(utils.handleOneForAll(target, damage), 0, 99999)
        damage = utils.clamp(utils.handleStoneskin(target, damage), -99999, 99999)
    end

    -- Apply damage or healing on target.
    if damage > 0 then
        local actionDamageType = params.physicalElement > 0 and params.physicalElement or xi.damageType.ELEMENTAL + params.magicalElement

        target:takeDamage(damage, actor, params.attackType, actionDamageType)
    elseif damage < 0 then
        target:addHP(-damage)
    end

    -- Return animation displayed, message in chat log and the number that the message should display (if any).
    if damage > 0 then
        return params.animation, params.messageDamage, damage
    elseif damage < 0 then
        return params.animation, params.messageHeal, -damage
    else
        return 0, 0, 0
    end
end
