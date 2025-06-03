-----------------------------------
-- Spell: Pinecone Bomb
-- Additional effect: Sleep. Duration of effect varies with TP
-- Spell cost: 48 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 2
-- Stat Bonus: STR+1
-- Level: 36
-- Casting Time: 2.5 seconds
-- Recast Time: 26.5 seconds
-- Skillchain Element(s): Liquefaction
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
    params.scattr     = xi.skillchainType.LIQUEFACTION
    params.numhits    = 1
    params.multiplier = 2.25
    params.tp150      = 2.25
    params.tp300      = 2.25
    params.azuretp    = 2.25
    params.duppercap  = 37
    params.str_wsc    = 0.2
    params.dex_wsc    = 0.0
    params.vit_wsc    = 0.0
    params.agi_wsc    = 0.2
    params.int_wsc    = 0.0
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
        [1] = { xi.effect.SLEEP_I, 1, 0, 60 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
