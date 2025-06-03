-----------------------------------
-- Table defining diferent status effect properties.
-----------------------------------
-- Info
-- Resistance:  https://wiki-ffo-jp.translate.goog/html/1801.html?_x_tr_sl=ja&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=sc
-- Effects:     https://wiki-ffo-jp.translate.goog/html/1720.html?_x_tr_sl=ja&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=sc
-- Resist:      https://wiki-ffo-jp.translate.goog/html/795.html?_x_tr_sl=ja&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=sc
-- Immunobreak: https://wiki-ffo-jp.translate.goog/html/27204.html?_x_tr_sl=ja&_x_tr_tl=en&_x_tr_hl=en&_x_tr_pto=sc

-- NOTE: I have yet to find a case where the effect "associated element" isnt determined by the element of the action that causes it.
-- Example: Siren's elegy is wind while spell elegies are earth. Same effect, diferent elements.
-- Unlike sleep, elegy effect doesnt have an associated "effect resistance rank" and uses "element resistance rank" instead.
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.statusEffect = xi.combat.statusEffect or {}
-----------------------------------

-- Table column names.
local column =
{
    EFFECT_NULLIFIED_BY = 1, -- [effect] is nullified by { effect }. In other words, [effect] cant be applied because { effect } is active.
    EFFECT_NULLIFIES    = 2, -- TODO: IMPLEMENT. [effect] nullifies { effect }.
    EFFECT_ELEMENT      = 3, -- Players and most effects dont have "effect resistance ranks", so they always use the effect "associated element" "resistance rank".
    EFFECT_IMMUNITY     = 4, -- Detected by "Completely resists" message. Cant immunobreak/resistance-hack it.
    MOD_RESIST_TRAIT    = 5, -- Detected by "Resist!" message. Cant immunobreak/resistance-hack it if triggered.
    MOD_RESIST_RANK     = 6, -- TODO: IMPLEMENT. For mobs, status effects can either: Use an specific status effect ressistance rank OR use their associated element resistance rank.
    MOD_MAGIC_EVASION   = 7,
    MOD_IMMUNOBREAK     = 8,
}

-- Table associating an status effect with their corresponding immunobreak, MEVA and resistance modifiers and immunities.
xi.combat.statusEffect.dataTable =
{
    [xi.effect.ADDLE        ] = { 0,               xi.effect.NOCTURNE, xi.element.FIRE,    xi.immunity.ADDLE,      xi.mod.SLOWRES,     0, 0,                    xi.mod.ADDLE_IMMUNOBREAK    }, -- Addle cant be immunobroken?
    [xi.effect.AMNESIA      ] = { 0,               0,                  xi.element.FIRE,    0,                      xi.mod.AMNESIARES,  0, xi.mod.AMNESIA_MEVA,  0                           },
    [xi.effect.BIND         ] = { 0,               0,                  xi.element.ICE,     xi.immunity.BIND,       xi.mod.BINDRES,     0, xi.mod.BIND_MEVA,     xi.mod.BIND_IMMUNOBREAK     },
    [xi.effect.BLINDNESS    ] = { 0,               0,                  xi.element.DARK,    xi.immunity.BLIND,      xi.mod.BLINDRES,    0, xi.mod.BLIND_MEVA,    xi.mod.BLIND_IMMUNOBREAK    },
    [xi.effect.BURN         ] = { xi.effect.DROWN, 0,                  xi.element.FIRE,    0,                      0,                  0, 0,                    0                           },
    [xi.effect.CHOKE        ] = { xi.effect.FROST, 0,                  xi.element.WIND,    0,                      0,                  0, 0,                    0                           },
    [xi.effect.CURSE_I      ] = { 0,               0,                  xi.element.DARK,    xi.immunity.NONE,       xi.mod.CURSERES,    0, xi.mod.CURSE_MEVA,    0                           },
    [xi.effect.DROWN        ] = { xi.effect.SHOCK, 0,                  xi.element.WATER,   0,                      0,                  0, 0,                    0                           },
    [xi.effect.FLASH        ] = { 0,               0,                  xi.element.LIGHT,   xi.immunity.BLIND,      xi.mod.BLINDRES,    0, xi.mod.BLIND_MEVA,    xi.mod.BLIND_IMMUNOBREAK    },
    [xi.effect.FROST        ] = { xi.effect.BURN,  0,                  xi.element.ICE,     0,                      0,                  0, 0,                    0                           },
    [xi.effect.NOCTURNE     ] = { xi.effect.ADDLE, 0,                  xi.element.FIRE,    xi.immunity.ADDLE,      xi.mod.SLOWRES,     0, 0,                    0                           },
    [xi.effect.NONE         ] = { 0,               0,                  xi.element.DARK,    xi.immunity.DISPEL,     0,                  0, 0,                    0                           },
    [xi.effect.PARALYSIS    ] = { 0,               0,                  xi.element.ICE,     xi.immunity.PARALYZE,   xi.mod.PARALYZERES, 0, xi.mod.PARALYZE_MEVA, xi.mod.PARALYZE_IMMUNOBREAK },
    [xi.effect.PETRIFICATION] = { 0,               0,                  xi.element.EARTH,   xi.immunity.PETRIFY,    xi.mod.PETRIFYRES,  0, xi.mod.PETRIFY_MEVA,  xi.mod.PETRIFY_IMMUNOBREAK  },
    [xi.effect.PLAGUE       ] = { 0,               0,                  xi.element.FIRE,    xi.immunity.PLAGUE,     xi.mod.VIRUSRES,    0, xi.mod.VIRUS_MEVA,    0                           },
    [xi.effect.POISON       ] = { 0,               0,                  xi.element.WATER,   xi.immunity.POISON,     xi.mod.POISONRES,   0, xi.mod.POISON_MEVA,   xi.mod.POISON_IMMUNOBREAK   },
    [xi.effect.RASP         ] = { xi.effect.CHOKE, 0,                  xi.element.EARTH,   0,                      0,                  0, 0,                    0                           },
    [xi.effect.SHOCK        ] = { xi.effect.RASP,  0,                  xi.element.THUNDER, 0,                      0,                  0, 0,                    0                           },
    [xi.effect.SILENCE      ] = { 0,               0,                  xi.element.WIND,    xi.immunity.SILENCE,    xi.mod.SILENCERES,  0, xi.mod.SILENCE_MEVA,  xi.mod.SILENCE_IMMUNOBREAK  },
    [xi.effect.SLEEP_I      ] = { 0,               0,                  xi.element.DARK,    xi.immunity.DARK_SLEEP, xi.mod.SLEEPRES,    0, xi.mod.SLEEP_MEVA,    xi.mod.SLEEP_IMMUNOBREAK    },
    [xi.effect.SLOW         ] = { 0,               0,                  xi.element.EARTH,   xi.immunity.SLOW,       xi.mod.SLOWRES,     0, xi.mod.SLOW_MEVA,     xi.mod.SLOW_IMMUNOBREAK     },
    [xi.effect.STUN         ] = { 0,               0,                  xi.element.THUNDER, xi.immunity.STUN,       xi.mod.STUNRES,     0, xi.mod.STUN_MEVA,     0                           },
    [xi.effect.WEIGHT       ] = { 0,               0,                  xi.element.WIND,    xi.immunity.GRAVITY,    xi.mod.GRAVITYRES,  0, xi.mod.GRAVITY_MEVA,  xi.mod.GRAVITY_IMMUNOBREAK  },
}

-----------------------------------
-- Helper functions to easily fetch table data.
-----------------------------------
xi.combat.statusEffect.getNullificatingEffect = function(effectId)
    -- Sanitize fed value
    local effectToCheck = utils.defaultIfNil(effectId, 0)

    -- Fetch effect ID from table if entry exists.
    if xi.combat.statusEffect.dataTable[effectToCheck] then
        return xi.combat.statusEffect.dataTable[effectToCheck][column.EFFECT_NULLIFIED_BY]
    end

    return 0
end

xi.combat.statusEffect.getEffectToRemove = function(effectId)
    -- Sanitize fed value
    local effectToCheck = utils.defaultIfNil(effectId, 0)

    -- Fetch effect ID from table if entry exists.
    if xi.combat.statusEffect.dataTable[effectToCheck] then
        return xi.combat.statusEffect.dataTable[effectToCheck][column.EFFECT_NULLIFIES]
    end

    return 0
end

xi.combat.statusEffect.getAssociatedElement = function(effectId, actionElement)
    -- Sanitize fed values
    local effectToCheck  = utils.defaultIfNil(effectId, 0)
    local elementToCheck = utils.defaultIfNil(actionElement, 0)

    -- Sleep exception.
    if effectToCheck == xi.effect.SLEEP_I then
        return elementToCheck
    end

    -- Fetch element from table if entry exists.
    if xi.combat.statusEffect.dataTable[effectToCheck] then
        return xi.combat.statusEffect.dataTable[effectToCheck][column.EFFECT_ELEMENT]
    end

    -- Assume the effect "element" is the same as the action element.
    return elementToCheck
end

xi.combat.statusEffect.getAssociatedImmunity = function(effectId, actionElement)
    -- Sanitize fed values
    local effectToCheck  = utils.defaultIfNil(effectId, 0)
    local elementToCheck = utils.defaultIfNil(actionElement, 0)

    -- Sleep exception.
    if
        effectToCheck == xi.effect.SLEEP_I and
        elementToCheck == xi.element.LIGHT
    then
        return xi.immunity.LIGHT_SLEEP
    end

    -- Fetch immunity from table if entry exists.
    if xi.combat.statusEffect.dataTable[effectToCheck] then
        return xi.combat.statusEffect.dataTable[effectToCheck][column.EFFECT_IMMUNITY]
    end

    return 0
end

xi.combat.statusEffect.getAssociatedResistTraitModifier = function(effectId)
    -- Sanitize fed value
    local effectToCheck  = utils.defaultIfNil(effectId, 0)

    -- Fetch modifier ID from table if entry exists.
    if xi.combat.statusEffect.dataTable[effectToCheck] then
        return xi.combat.statusEffect.dataTable[effectToCheck][column.MOD_RESIST_TRAIT]
    end

    return 0
end

xi.combat.statusEffect.getAssociatedResistanceRankModifier = function(effectId)
    -- Sanitize fed value
    local effectToCheck  = utils.defaultIfNil(effectId, 0)

    -- Fetch modifier ID from table if entry exists.
    if xi.combat.statusEffect.dataTable[effectToCheck] then
        return xi.combat.statusEffect.dataTable[effectToCheck][column.MOD_RESIST_RANK]
    end

    return 0
end

xi.combat.statusEffect.getAssociatedMagicEvasionModifier = function(effectId)
    -- Sanitize fed value
    local effectToCheck  = utils.defaultIfNil(effectId, 0)

    -- Fetch modifier ID from table if entry exists.
    if xi.combat.statusEffect.dataTable[effectToCheck] then
        return xi.combat.statusEffect.dataTable[effectToCheck][column.MOD_MAGIC_EVASION]
    end

    return 0
end

xi.combat.statusEffect.getAssociatedImmunobreakModifier = function(effectId)
    -- Sanitize fed value
    local effectToCheck  = utils.defaultIfNil(effectId, 0)

    -- Fetch modifier ID from table if entry exists.
    if xi.combat.statusEffect.dataTable[effectToCheck] then
        return xi.combat.statusEffect.dataTable[effectToCheck][column.MOD_IMMUNOBREAK]
    end

    return 0
end

-----------------------------------
-- Helper functions to check target effect nullification.
-----------------------------------
xi.combat.statusEffect.isTargetImmune = function(target, effectId, actionElement)
    if not target:isMob() then
        return false
    end

    local immunityId = xi.combat.statusEffect.getAssociatedImmunity(effectId, actionElement)
    if
        immunityId > 0 and
        target:hasImmunity(immunityId)
    then
        return true
    end

    return false
end

xi.combat.statusEffect.isTargetResistant = function(actor, target, effectId)
    local modifierId = xi.combat.statusEffect.getAssociatedResistTraitModifier(effectId)
    if modifierId == 0 then
        return false
    end

    local resistancePower = target:getMod(modifierId) + target:getMod(xi.mod.STATUSRES) + 5
    if resistancePower <= 5 then
        return false
    end

    -- TODO: Investigate if this happens always or not. Ex: Terror.
    if actor:isNM() then
        resistancePower = math.floor(resistancePower / 2)
    end

    if math.random(1, 100) <= resistancePower then
        return true
    end

    return false
end

xi.combat.statusEffect.isEffectNullified = function(target, effectId)
    local nullificatingEffect = xi.combat.statusEffect.getNullificatingEffect(effectId)
    if
        nullificatingEffect > 0 and
        target:hasStatusEffect(nullificatingEffect)
    then
        return true
    end

    return false
end
