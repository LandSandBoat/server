-----------------------------------
-- Spell: Body Slam
-- Delivers an area attack. Damage varies with TP
-- Spell cost: 74 MP
-- Monster Type: Dragon
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: VIT+1, MP+5
-- Level: 62
-- Casting Time: 1 seconds
-- Recast Time: 27.75 seconds
-- Skillchain Element(s): Impaction
-- Combos: Max HP Boost
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.DRAGON
    params.tpmod = TPMOD_ATTACK
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.BLUNT
    params.scattr = xi.skillchainType.IMPACTION
    params.numhits = 1
    params.multiplier = 1.5
    params.tp150 = 1.5
    params.tp300 = 1.5
    params.azuretp = 1.5
    params.duppercap = 75
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.4
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
