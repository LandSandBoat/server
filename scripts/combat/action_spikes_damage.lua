-----------------------------------
-- Global file for additional effects (damage)
-----------------------------------
require('scripts/globals/spells/damage_spell')
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.action = xi.combat.action or {}
-----------------------------------

local defaultsTable =
{
    [xi.element.NONE   ] = { xi.subEffect.DEATH_SPIKES  },
    [xi.element.FIRE   ] = { xi.subEffect.BLAZE_SPIKES  },
    [xi.element.ICE    ] = { xi.subEffect.ICE_SPIKES    },
    [xi.element.WIND   ] = { xi.subEffect.GALE_SPIKES   },
    [xi.element.EARTH  ] = { xi.subEffect.CLOD_SPIKES   },
    [xi.element.THUNDER] = { xi.subEffect.SHOCK_SPIKES  },
    [xi.element.WATER  ] = { xi.subEffect.DELUGE_SPIKES },
    [xi.element.LIGHT  ] = { xi.subEffect.GLINT_SPIKES  },
    [xi.element.DARK   ] = { xi.subEffect.DREAD_SPIKES  },
}

-----------------------------------
-- Local functions to ensure defaults are set.
-----------------------------------
local function validateParameters(actor, target, fedData)
    local params = {}

    -- Chance.
    params.chance          = fedData.chance or 100 -- Default: Always proc.

    -- Limit undead
    params.limitUndead     = fedData.limitUndead or false -- Default: Works on undead.

    -- Base damage parameters.
    params.basePower       = fedData.basePower or 0

    -- Action properties.
    params.attackType      = fedData.attackType or xi.attackType.SPECIAL   -- Physical, Magical, Ranged, Breath or Special.
    params.physicalElement = fedData.physicalElement or xi.damageType.NONE -- None, H2H, Slashing, Piercing or Blunt.
    params.magicalElement  = fedData.magicalElement or xi.element.NONE     -- None, Fire, Ice, Wind, Earth, Thunder, Water, Light, Dark.
    params.actorStat       = fedData.actorStat or 0
    params.targetStat      = fedData.targetStat or params.actorStat        -- Currently unused. For future use.
    params.skillRank       = fedData.skillRank or 0
    params.macc            = fedData.macc or 0

    -- Multiplier properties.
    params.canMAB          = fedData.canMAB or false
    params.canResist       = fedData.canResist or false
    params.lowestResist    = fedData.lowestResist or 0.125
    params.canResistExtra  = fedData.canResistExtra or false

    -- Drain properties.
    params.drainHP         = fedData.drainHP or false
    params.drainMP         = fedData.drainMP or false
    params.drainTP         = fedData.drainTP or false
    params.overDrain       = fedData.overDrain or false

    -- Animations and messaging.
    params.animation       = fedData.animation or defaultsTable[params.magicalElement][1]
    params.messageDamage   = fedData.messageDamage or xi.msg.basic.SPIKES_EFFECT_DMG
    params.messageHeal     = fedData.messageHeal or xi.msg.basic.SPIKES_EFFECT_HEAL

    return params
end

-----------------------------------
-- Global functions called from "emtity.onSpikesDamage()"
-----------------------------------
xi.combat.action.executeSpikesDamage = function(actor, target, fedData)
    local params = validateParameters(actor, target, fedData)

    -- Early return: No proc.
    if math.randomInt(1, 100) > params.chance then
        return 0, 0, 0
    end

    -- Early return: Limit undead.
    if params.limitUndead and params.aeTarget:isUndead() then
        return 0, 0, 0
    end

    -- Early return: Effect is nullified.
    local nullification = xi.spells.damage.calculateNullification(params.aeTarget, params.magicalElement, params.attackType == xi.attackType.PHYSICAL, params.params.attackType == xi.attackType.MAGICAL, params.attackType == xi.attackType.RANGED, params.attackType == xi.attackType.BREATH)
    if nullification == 0 then
        return 0, 0, 0
    end

    -- Early return: Effect is resisted.
    local multiplierResist = params.canResist and xi.combat.magicHitRate.calculateResistRate(actor, params.aeTarget, 0, 0, params.skillRank, params.magicalElement, params.actorStat, 0, params.macc) or 1
    if multiplierResist < params.lowestResist then
        return 0, 0, 0
    end

    -- Calculate base power.
    local damage = params.basePower + actor:getMod(params.actorStat) - params.aeTarget:getMod(params.targetStat)

    -- Calculate mandatory multipliers.
    local multiplierAbsorption         = xi.spells.damage.calculateAbsorption(params.aeTarget, params.magicalElement, params.attackType == xi.attackType.PHYSICAL, params.params.attackType == xi.attackType.MAGICAL, params.attackType == xi.attackType.RANGED, params.attackType == xi.attackType.BREATH)
    local multiplierDamageTypeSDT      = xi.combat.damage.calculateDamageAdjustment(params.aeTarget, params.attackType == xi.attackType.PHYSICAL, params.attackType == xi.attackType.MAGICAL, params.attackType == xi.attackType.RANGED, params.attackType == xi.attackType.BREATH)
    local multiplierPhysicalElementSDT = xi.combat.damage.physicalElementSDT(params.aeTarget, params.physicalElement)
    local multiplierMagicalElementSDT  = xi.combat.damage.magicalElementSDT(params.aeTarget, params.magicalElement)
    local multiplierDayWeather         = xi.spells.damage.calculateDayAndWeather(actor, params.magicalElement, false)

    -- Calculate optional multipliers.
    local multiplierMagicDiff          = params.canMAB and xi.spells.damage.calculateMagicBonusDiff(actor, params.aeTarget, 0, 0, params.magicalElement, 0) or 1
    local multiplierForcedResistTier   = params.canResistExtra and xi.spells.damage.calculateAdditionalResistTier(actor, params.aeTarget, params.magicalElement) or 1

    -- Calculate final damage.
    damage = math.floor(damage * multiplierAbsorption)
    damage = math.floor(damage * multiplierDamageTypeSDT)
    damage = math.floor(damage * multiplierPhysicalElementSDT)
    damage = math.floor(damage * multiplierMagicalElementSDT)
    damage = math.floor(damage * multiplierDayWeather)
    damage = math.floor(damage * multiplierMagicDiff)
    damage = math.floor(damage * multiplierResist)
    damage = math.floor(damage * multiplierForcedResistTier)

    -- Phalanx, One for all, Stoneskin.
    if damage > 0 then
        damage = utils.clamp(utils.handlePhalanx(params.aeTarget, damage), 0, 99999)
        damage = utils.clamp(utils.handleOneForAll(params.aeTarget, damage), 0, 99999)
        damage = utils.clamp(utils.handleStoneskin(params.aeTarget, damage), 0, 99999)
    end

    -- Drain HP, MP or TP
    if params.drainHP then
        damage               = params.overDrain and damage or utils.clamp(damage, 0, params.aeTarget:getHP())
        params.messageDamage = xi.msg.basic.ADD_EFFECT_HP_DRAIN
        actor:addHP(damage)
    end

    if params.drainMP then
        damage               = params.overDrain and damage or utils.clamp(damage, 0, params.aeTarget:getMP())
        params.messageDamage = xi.msg.basic.ADD_EFFECT_MP_DRAIN
        actor:addMP(damage)
    end

    if params.drainTP then
        damage               = params.overDrain and damage or utils.clamp(damage, 0, params.aeTarget:getTP())
        params.messageDamage = xi.msg.basic.ADD_EFFECT_TP_DRAIN
        actor:addTP(damage)
    end

    if damage < 0 then
        params.aeTarget:addHP(-damage) -- Heal target.
        return params.animation, params.messageHeal, -damage
    end

    local actionDamageType = params.physicalElement > 0 and params.physicalElement or xi.damageType.ELEMENTAL + params.magicalElement
    params.aeTarget:takeDamage(damage, actor, params.attackType, actionDamageType)

    return params.animation, params.messageDamage, damage
end
