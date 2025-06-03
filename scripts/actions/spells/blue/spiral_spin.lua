-----------------------------------
-- Spell: Spiral Spin
-- Chance of effect varies with TP. Additional Effect: Accuracy Down
-- Spell cost: 39 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 3
-- Stat Bonus: STR+1 HP+5
-- Level: 60
-- Casting Time: 4 seconds
-- Recast Time: 45 seconds
-- Skillchain property: Transfixion
-- Combos: Plantoid Killer
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem  = xi.ecosystem.VERMIN
    params.tpmod      = xi.spells.blue.tpMod.DURATION
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.scattr     = xi.skillchainType.TRANSFIXION
    params.numhits    = 1
    params.multiplier = 2.0
    params.tp150      = 2.0
    params.tp300      = 2.0
    params.azuretp    = 2.0
    params.duppercap  = 69
    params.str_wsc    = 0.0
    params.dex_wsc    = 0.0
    params.vit_wsc    = 0.0
    params.agi_wsc    = 0.3
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
        [1] = { xi.effect.ACCURACY_DOWN, 15, 0, 60 },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return damage
end

return spellObject
