-----------------------------------
-- Spell: Uppercut
-- Damage varies with TP
-- Spell cost: 31 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: STR+2, DEX+1
-- Level: 38
-- Casting Time: 0.5 seconds
-- Recast Time: 17.75 seconds
-- Skillchain Element(s): Liquefaction/Impaction
-- Combos: Attack Bonus
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.PLANTOID
    params.tpmod = TPMOD_ATTACK
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.H2H
    params.scattr = xi.skillchainType.LIQUEFACTION
    params.scattr2 = xi.skillchainType.IMPACTION
    params.numhits = 1
    params.multiplier = 1.5
    params.tp150 = 1.5
    params.tp300 = 1.5
    params.azuretp = 1.5
    params.duppercap = 39
    params.str_wsc = 0.35
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
