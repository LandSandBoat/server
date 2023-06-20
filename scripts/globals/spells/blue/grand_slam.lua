-----------------------------------
-- Spell: Grand Slam
-- Delivers an area attack. Damage varies with TP
-- Spell cost: 24 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 2
-- Stat Bonus: INT+1
-- Level: 30
-- Casting Time: 1 seconds
-- Recast Time: 14.25 seconds
-- Skillchain Element(s): Induration
-- Combos: Defense Bonus
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.tpmod = TPMOD_ATTACK
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.H2H
    params.scattr = SC_INDURATION
    params.numhits = 1
    params.multiplier = 1.0
    params.tp150 = 1.0
    params.tp300 = 1.0
    params.azuretp = 1.0
    params.duppercap = 33
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.3
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.ignorefstrcap = true -- Grand Slam doesn't have an fSTR cap

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
