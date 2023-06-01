-----------------------------------
-- STATUSES AND MODS
-- Contains variable-ized definitions of things like core enums for use in lua scripts.
-----------------------------------
xi = xi or {}

-----------------------------------
-- SC masks (not currently used in code base)
-----------------------------------

-- EFFECT_SKILLCHAIN0    = 0x200
-- EFFECT_SKILLCHAIN1    = 0x400
-- EFFECT_SKILLCHAIN2    = 0x800
-- EFFECT_SKILLCHAIN3    = 0x1000
-- EFFECT_SKILLCHAIN4    = 0x2000
-- EFFECT_SKILLCHAIN5    = 0x4000
-- EFFECT_SKILLCHAINMASK = 0x7C00

function removeSleepEffects(target)
    target:delStatusEffect(xi.effect.SLEEP_I)
    target:delStatusEffect(xi.effect.SLEEP_II)
    target:delStatusEffect(xi.effect.LULLABY)
end

function hasSleepEffects(target)
    return target:hasStatusEffect(xi.effect.SLEEP_I) or target:hasStatusEffect(xi.effect.SLEEP_II) or target:hasStatusEffect(xi.effect.LULLABY)
end

-----------------------------------
-- Drop Type (not currently used in code base)
-----------------------------------

-- DROP_NORMAL  = 0x00
-- DROP_GROUPED = 0x01
-- DROP_STEAL   = 0x02
-- DROP_DESPOIL = 0x04
