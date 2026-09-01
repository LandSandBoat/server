-----------------------------------
-- Spell: Sandspin
-- Deals earth damage to enemies within range. Additional Effect: Accuracy Down
-- Spell cost: 10 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 2
-- Stat Bonus: VIT+1
-- Level: 1
-- Casting Time: 1.5 seconds
-- Recast Time: 9.75 seconds
-- Magic Bursts on: Scission, Gravitation, Darkness
-- Combos: None
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params       = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem   = xi.ecosystem.AMORPH
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.EARTH
    params.dStat       = xi.mod.INT

    params.ftp0            = 1.0
    params.dStatMultiplier = 1.0
    params.baseDamageCap   = 13

    params.int_wsc     = 0.2

    -- Handle damage.
    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    if damage <= 0 then
        return damage
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.ACCURACY_DOWN, 25, 0, 60 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
