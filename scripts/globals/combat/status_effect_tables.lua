-----------------------------------
-- Table defining diferent status effect properties.
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.statusEffect = xi.combat.statusEffect or {}
-----------------------------------

-- Table associating an status effect with their corresponding immunobreak, MEVA and resistance modifiers and immunities.
xi.combat.statusEffect.dataTable =
{
    [xi.effect.ADDLE        ] = { xi.immunity.ADDLE,      0,                  0,                    xi.mod.ADDLE_IMMUNOBREAK    },
    [xi.effect.BIND         ] = { xi.immunity.BIND,       xi.mod.BINDRES,     xi.mod.BIND_MEVA,     xi.mod.BIND_IMMUNOBREAK     },
    [xi.effect.BLINDNESS    ] = { xi.immunity.BLIND,      xi.mod.BLINDRES,    xi.mod.BLIND_MEVA,    xi.mod.BLIND_IMMUNOBREAK    },
    [xi.effect.CURSE_I      ] = { xi.immunity.NONE,       xi.mod.CURSERES,    xi.mod.CURSE_MEVA,    0                           },
    [xi.effect.NONE         ] = { xi.immunity.DISPEL,     0,                  0,                    0                           },
    [xi.effect.PARALYSIS    ] = { xi.immunity.PARALYZE,   xi.mod.PARALYZERES, xi.mod.PARALYZE_MEVA, xi.mod.PARALYZE_IMMUNOBREAK },
    [xi.effect.PETRIFICATION] = { xi.immunity.PETRIFY,    xi.mod.PETRIFYRES,  xi.mod.PETRIFY_MEVA,  xi.mod.PETRIFY_IMMUNOBREAK  },
    [xi.effect.PLAGUE       ] = { xi.immunity.NONE,       xi.mod.VIRUSRES,    xi.mod.VIRUS_MEVA,    0                           },
    [xi.effect.POISON       ] = { xi.immunity.POISON,     xi.mod.POISONRES,   xi.mod.POISON_MEVA,   xi.mod.POISON_IMMUNOBREAK   },
    [xi.effect.SILENCE      ] = { xi.immunity.SILENCE,    xi.mod.SILENCERES,  xi.mod.SILENCE_MEVA,  xi.mod.SILENCE_IMMUNOBREAK  },
    [xi.effect.SLEEP_I      ] = { xi.immunity.DARK_SLEEP, xi.mod.SLEEPRES,    xi.mod.SLEEP_MEVA,    xi.mod.SLEEP_IMMUNOBREAK    },
    [xi.effect.SLOW         ] = { xi.immunity.SLOW,       xi.mod.SLOWRES,     xi.mod.SLOW_MEVA,     xi.mod.SLOW_IMMUNOBREAK     },
    [xi.effect.STUN         ] = { xi.immunity.STUN,       xi.mod.STUNRES,     xi.mod.STUN_MEVA,     0                           },
    [xi.effect.WEIGHT       ] = { xi.immunity.GRAVITY,    xi.mod.GRAVITYRES,  xi.mod.GRAVITY_MEVA,  xi.mod.GRAVITY_IMMUNOBREAK  },
}

-----------------------------------
-- Helper functions to easily fetch table data.
-----------------------------------
xi.combat.statusEffect.getAssociatedImmunity = function(effectId, actionElement)
    -- Sanitize fed values
    local effectToCheck  = effectId or 0
    local elementToCheck = actionElement or 0

    -- Fetch immunity from table if entry exists.
    local associatedImmunity = 0

    if xi.combat.statusEffect.dataTable[effectToCheck] then
        associatedImmunity = xi.combat.statusEffect.dataTable[effectToCheck][1]
    end

    -- Sleep exception.
    if
        associatedImmunity == xi.immunity.DARK_SLEEP and
        elementToCheck == xi.element.LIGHT
    then
        associatedImmunity = xi.immunity.LIGHT_SLEEP
    end

    return associatedImmunity
end

xi.combat.statusEffect.getAssociatedResistanceModifier = function(effectId)
    -- Sanitize fed value
    local effectToCheck = effectId or 0

    -- Fetch modifier ID from table if entry exists.
    local associatedResistanceModifier = 0

    if xi.combat.statusEffect.dataTable[effectToCheck] then
        associatedResistanceModifier = xi.combat.statusEffect.dataTable[effectToCheck][2]
    end

    return associatedResistanceModifier
end

xi.combat.statusEffect.getAssociatedMagicEvasionModifier = function(effectId)
    -- Sanitize fed value
    local effectToCheck = effectId or 0

    -- Fetch modifier ID from table if entry exists.
    local associatedMagicEvasionModifier = 0

    if xi.combat.statusEffect.dataTable[effectToCheck] then
        associatedMagicEvasionModifier = xi.combat.statusEffect.dataTable[effectToCheck][3]
    end

    return associatedMagicEvasionModifier
end

xi.combat.statusEffect.getAssociatedImmunobreakModifier = function(effectId)
    -- Sanitize fed value
    local effectToCheck = effectId or 0

    -- Fetch modifier ID from table if entry exists.
    local associatedImmunobreakModifier = 0

    if xi.combat.statusEffect.dataTable[effectToCheck] then
        associatedImmunobreakModifier = xi.combat.statusEffect.dataTable[effectToCheck][4]
    end

    return associatedImmunobreakModifier
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
    local modifierId = xi.combat.statusEffect.getAssociatedResistanceModifier(effectId)
    if modifierId == 0 then
        return false
    end

    local resistancePower = target:getMod(modifierId) + target:getMod(xi.mod.STATUSRES)
    if resistancePower == 0 then
        return false
    end

    local roll      = math.random(1, 100)
    resistancePower = resistancePower + 5

    if actor:isNM() then
        resistancePower = math.floor(resistancePower / 2)
    end

    if roll <= resistancePower then
        return true
    end

    return false
end
