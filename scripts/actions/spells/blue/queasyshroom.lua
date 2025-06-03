-----------------------------------
-- Spell: Queasyshroom
-- Additional effect: Poison. Duration of effect varies with TP
-- Spell cost: 20 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 2
-- Stat Bonus: HP-5, MP+5
-- Level: 8
-- Casting Time: 2 seconds
-- Recast Time: 15 seconds
-- Skillchain Element(s): Compression
-- Combos: None
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem  = xi.ecosystem.PLANTOID
    params.tpmod      = xi.spells.blue.tpMod.DURATION
    params.attackType = xi.attackType.RANGED
    params.damageType = xi.damageType.PIERCING
    params.scattr     = xi.skillchainType.COMPRESSION
    params.numhits    = 1
    params.multiplier = 1.75
    params.tp150      = 1.75
    params.tp300      = 1.75
    params.azuretp    = 1.75
    params.duppercap  = 15
    params.str_wsc    = 0.0
    params.dex_wsc    = 0.0
    params.vit_wsc    = 0.0
    params.agi_wsc    = 0.0
    params.int_wsc    = 0.2
    params.mnd_wsc    = 0.0
    params.chr_wsc    = 0.0

    -- Handle damage.
    local damage = xi.spells.blue.usePhysicalSpell(caster, target, spell, params)

    if damage <= 0 then
        return damage
    end

    -- Handle status effects.
    local effectTable =
    {
        [1] = { xi.effect.POISON, 3, 3, 180 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
