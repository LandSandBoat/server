-----------------------------------
-- Spell: Regurgitation
-- Deals Water damage to an enemy. Additional Effect: Bind
-- Spell cost: 69 MP
-- Monster Type: Lizards
-- Spell Type: Magical (Water)
-- Blue Magic Points: 1
-- Stat Bonus: INT+1 MND+1 MP+3
-- Level: 68
-- Casting Time: 5 seconds
-- Recast Time: 24 seconds
-- Magic Bursts on: Reverberation, Distortion, and Darkness
-- Combos: Resist Gravity
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params      = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem   = xi.ecosystem.LIZARD
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.WATER
    params.dStat       = xi.mod.INT

    params.ftp0            = 1.83
    params.dStatMultiplier = 2.0
    params.baseDamageCap   = 69

    params.mnd_wsc     = 0.3

    -- Handle damage.
    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)
    if caster:isBehind(target) then
        damage = math.floor(damage * 1.25)
    end

    if damage <= 0 then
        return damage
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.BIND, 1, 0, 30 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
