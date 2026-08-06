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
local function validateParameters(actor, target, fedData)
    local params = {}

    -- Additional effect target.
    params.aeTarget        = fedData.aeTarget or target -- Default to the current attack target.

    -- Chance.
    params.chance          = fedData.chance or 100 -- Default: Always proc.

    -- Limit undead
    params.limitUndead     = fedData.limitUndead or false -- Default: Works on undead.

    -- Bypass regular En-Spell > AE > Daze priority.
    params.ignoreEnSpell   = fedData.ignoreEnSpell or false -- Assume En-Spell takes priority.

    -- Base damage parameters.
    params.basePower       = fedData.basePower or 0

    -- Action properties.
    params.attackType      = fedData.attackType or xi.attackType.SPECIAL   -- Physical, Magical, Ranged, Breath or Special.
    params.physicalElement = fedData.physicalElement or xi.damageType.NONE -- None, H2H, Slashing, Piercing or Blunt.
    params.magicalElement  = fedData.magicalElement or xi.element.NONE     -- None, Fire, Ice, Wind, Earth, Thunder, Water, Light, Dark.
    params.actorStat       = fedData.actorStat or 0
    params.targetStat      = fedData.targetStat or params.actorStat        -- Currently unused. For future use.
    params.skillRank       = fedData.skillRank or xi.skillRank.A_PLUS
    params.bonusMacc       = fedData.bonusMacc or 0

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
    params.messageDamage   = fedData.messageDamage or xi.msg.basic.ADD_EFFECT_DMG
    params.messageHeal     = fedData.messageHeal or xi.msg.basic.ADD_EFFECT_HEAL

    return params
end

local enspellTable =
{
    [ 1] = xi.effect.ENFIRE,
    [ 2] = xi.effect.ENFIRE_II,
    [ 3] = xi.effect.ENBLIZZARD,
    [ 4] = xi.effect.ENBLIZZARD_II,
    [ 5] = xi.effect.ENAERO,
    [ 6] = xi.effect.ENAERO_II,
    [ 7] = xi.effect.ENSTONE,
    [ 8] = xi.effect.ENSTONE_II,
    [ 9] = xi.effect.ENTHUNDER,
    [10] = xi.effect.ENTHUNDER_II,
    [11] = xi.effect.ENWATER,
    [12] = xi.effect.ENWATER_II,
    [13] = xi.effect.ENLIGHT,
    [14] = xi.effect.ENDARK,
}

local function hasEnspell(actor)
    for i = 1, #enspellTable do
        if actor:hasStatusEffect(enspellTable[i]) then
            return true
        end
    end

    return false
end

-----------------------------------
-- Global functions called from "emtity.onAdditionalEffect()"
-----------------------------------

-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
xi.combat.action.executeAddEffectDamage = function(actor, target, fedData)
    local params = validateParameters(actor, target, fedData)

    -- Early return: En-spell override.
    if not params.ignoreEnSpell and hasEnspell(actor) then
        return 0, 0, 0
    end

    -- Early return: No proc.
    if math.randomInt(1, 10000) > params.chance * 100 then -- proc rates from add effect weapons have at least 2 digits of precision based on testing. input is 0-100 so this should be ok
        return 0, 0, 0
    end

    -- Early return: Limit undead.
    if params.limitUndead and params.aeTarget:isUndead() then
        return 0, 0, 0
    end

    -- Early return: Effect is nullified.
    local nullification = xi.spells.damage.calculateNullification(params.aeTarget, params.magicalElement, params.attackType == xi.attackType.PHYSICAL, params.attackType == xi.attackType.MAGICAL, params.attackType == xi.attackType.RANGED, params.attackType == xi.attackType.BREATH)
    if nullification == 0 then
        return 0, 0, 0
    end

    -- Early return: Effect is resisted.
    local multiplierResist = params.canResist and xi.combat.magicHitRate.calculateResistRate(actor, params.aeTarget, params) or 1
    if multiplierResist < params.lowestResist then
        return 0, 0, 0
    end

    -- Check if we absorb, to skip steps.
    local absorb = xi.spells.damage.calculateAbsorption(params.aeTarget, params.magicalElement, params.attackType == xi.attackType.PHYSICAL, params.attackType == xi.attackType.MAGICAL, params.attackType == xi.attackType.RANGED, params.attackType == xi.attackType.BREATH) < 0

    -- Calculate base power.
    local damage = utils.clamp(params.basePower + actor:getMod(params.actorStat) - params.aeTarget:getMod(params.targetStat), 0, 99999)

    -- Calculate mandatory multipliers.
    local multiplierDamageTypeSDT      = not absorb and xi.combat.damage.calculateDamageAdjustment(params.aeTarget, params.attackType == xi.attackType.PHYSICAL, params.attackType == xi.attackType.MAGICAL, params.attackType == xi.attackType.RANGED, params.attackType == xi.attackType.BREATH) or 1
    local multiplierPhysicalElementSDT = not absorb and xi.combat.damage.physicalElementSDT(params.aeTarget, params.physicalElement) or 1
    local multiplierMagicalElementSDT  = not absorb and xi.combat.damage.magicalElementSDT(params.aeTarget, params.magicalElement) or 1
    local multiplierElementalStaff     = xi.spells.damage.calculateElementalStaffBonus(actor, params.magicalElement)
    local multiplierElementalAffinity  = xi.spells.damage.calculateElementalAffinityBonus(actor, params.magicalElement)
    local multiplierDayWeather         = xi.spells.damage.calculateDayAndWeather(actor, params.magicalElement, false)

    -- Calculate optional multipliers.
    local multiplierMagicDiff          = params.canMAB and xi.spells.damage.calculateMagicBonusDiff(actor, params.aeTarget, 0, 0, params.magicalElement, 0) or 1
    local multiplierForcedResistTier   = params.canResistExtra and xi.spells.damage.calculateAdditionalResistTier(actor, params.aeTarget, params.magicalElement) or 1

    -- Calculate final damage.
    damage = math.floor(damage * multiplierDamageTypeSDT)
    damage = math.floor(damage * multiplierPhysicalElementSDT)
    damage = math.floor(damage * multiplierMagicalElementSDT)
    damage = math.floor(damage * multiplierElementalStaff)
    damage = math.floor(damage * multiplierElementalAffinity)
    damage = math.floor(damage * multiplierDayWeather)
    damage = math.floor(damage * multiplierMagicDiff)
    damage = math.floor(damage * multiplierResist)
    damage = math.floor(damage * multiplierForcedResistTier)

    -- Phalanx, One for all, Stoneskin.
    if damage > 0 then
        damage = utils.clamp(utils.handlePhalanx(params.aeTarget, damage), 0, 99999)
        damage = utils.clamp(utils.handleOneForAll(params.aeTarget, damage), 0, 99999)
        damage = utils.handleStoneskin(params.aeTarget, damage, params.attackType)
    end

    -- Handle absorption.
    if absorb then
        -- Nullify drain-like AEs.
        local isDrain = params.drainHP or params.drainMP or params.drainTP
        if isDrain then
            return 0, 0, 0
        end

        params.aeTarget:addHP(damage) -- Heal target.
        return params.animation, params.messageHeal, damage
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

    -- Handle target damage listeners and other core-side stuff.
    local actionDamageType = params.physicalElement > 0 and params.physicalElement or xi.damageType.ELEMENTAL + params.magicalElement
    params.aeTarget:takeDamage(damage, actor, params.attackType, actionDamageType)

    return params.animation, params.messageDamage, damage
end
