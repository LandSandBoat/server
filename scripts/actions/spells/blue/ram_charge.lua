-----------------------------------
-- Spell: Ram Charge
-- Damage varies with TP
-- Spell cost: 79 MP
-- Monster Type: Beasts
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: HP+5
-- Level: 73
-- Casting Time: 0.5 seconds
-- Recast Time: 34.75 seconds
-- Skillchain Element(s): Fragmentation
-- Combos: Lizard Killer
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.BEAST
    params.tpmod = xi.spells.blue.tpMod.DAMAGE
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.BLUNT
    params.scattr = xi.skillchainType.FRAGMENTATION
    params.numhits = 1
    params.multiplier = 1.0
    params.tp150 = 1.375
    params.tp300 = 1.75
    params.azuretp = 1.875
    params.duppercap = 75
    params.str_wsc = 0.3
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.5
    params.chr_wsc = 0.0

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
