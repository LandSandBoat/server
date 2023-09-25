-----------------------------------
-- Spell: Asuran Claws
-- Delivers a sixfold attack. Accuracy varies with TP
-- Spell cost: 81 MP
-- Monster Type: Beasts
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 2
-- Stat Bonus: AGI +3
-- Level: 70
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Skillchain Element(s): Liquefaction/Impaction
-- Combos: Counter
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
    params.ecosystem = xi.ecosystem.BEAST
    params.tpmod = TPMOD_ACC
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.HTH
    params.scattr = SC_LIQUEFACTION
    params.scattr2 = SC_IMPACTION
    params.numhits = 6
    params.multiplier = 0.625
    params.tp150 = 0.625
    params.tp300 = 0.625
    params.azuretp = 0.625
    params.duppercap = 21
    -- D seems low for its level, but the spell never did good damage, so a low D is a good way of keeping overall damage down.
    -- More discussion on https://ffxiclopedia.fandom.com/wiki/Talk:Asuran_Claws
    params.str_wsc = 0.1
    params.dex_wsc = 0.1
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
