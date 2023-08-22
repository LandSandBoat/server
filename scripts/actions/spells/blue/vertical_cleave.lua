-----------------------------------
-- Spell: Vertical Cleave
-- Damage varies with TP
-- Spell cost: 86 MP
-- Monster Type: Luminians
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+1 HP-5 MP+5
-- Level: 75
-- Casting Time: 0.5 seconds
-- Recast Time: 37.25 seconds
-- Skillchain Element(s): Gravitation
-- Combos: Defense Bonus
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.LUMINIAN
    params.tpmod = TPMOD_ATTACK
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.scattr = xi.skillchainType.GRAVITATION
    params.numhits = 1
    params.multiplier = 3.0
    params.tp150 = 3.0
    params.tp300 = 3.0
    params.azuretp = 3.0
    params.duppercap = 75
    params.str_wsc = 0.5
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
