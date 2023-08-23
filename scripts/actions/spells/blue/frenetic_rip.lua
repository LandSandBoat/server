-----------------------------------
-- Spell: Frenetic Rip
-- Delivers a threefold attack. Damage varies with TP
-- Spell cost: 61 MP
-- Monster Type: Demon
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: INT+1
-- Level: 63
-- Casting Time: 0.5 seconds
-- Recast Time: 28.5 seconds
-- Skillchain Element: Induration
-- Combos: Accuracy Bonus
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.DEMON
    params.tpmod = TPMOD_DAMAGE
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.H2H
    params.scattr = xi.skillchainType.INDURATION
    params.numhits = 3
    params.multiplier = 1.36
    params.tp150 = 2.08
    params.tp300 = 2.36
    params.azuretp = 2.61
    params.duppercap = 75
    params.str_wsc = 0.2
    params.dex_wsc = 0.2
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
