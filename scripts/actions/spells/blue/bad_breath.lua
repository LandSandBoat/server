-----------------------------------
-- Spell: Bad Breath
-- Deals earth damage that inflicts multiple status ailments on enemies within a fan-shaped area originating from the caster
-- Spell cost: 212 MP
-- Monster Type: Plantoids
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 5
-- Stat Bonus: INT+2, MND+2
-- Level: 61
-- Casting Time: 8.75 seconds
-- Recast Time: 120 seconds
-- Magic Bursts on: Scission, Gravitation, Darkness
-- Combos: Fast Cast
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem  = xi.ecosystem.PLANTOID
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.EARTH
    params.diff       = 0 -- no stat increases magic accuracy
    params.skillType  = xi.skill.BLUE_MAGIC
    params.hpMod      = 8
    params.lvlMod     = 3
    params.isConal    = true

    -- Handle damage.
    local damage = xi.spells.blue.useBreathSpell(caster, target, spell, params)

    if damage <= 0 then
        return damage
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.SLOW,      2000, 0, 60 },
        [2] = { xi.effect.SILENCE,      1, 0, 60 },
        [3] = { xi.effect.PARALYSIS,   15, 0, 60 },
        [4] = { xi.effect.BIND,         1, 0, 60 },
        [5] = { xi.effect.WEIGHT,      20, 0, 60 },
        [6] = { xi.effect.POISON,       4, 0, 60 },
        [7] = { xi.effect.BLINDNESS,   20, 0, 60 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
