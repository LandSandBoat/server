-----------------------------------------
-- Spell: Hydro Shot
-- Additional effect: Enmity Down. Chance of effect varies with TP
-- Spell cost: 55 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: MND+2
-- Level: 63
-- Casting Time: 0.5 seconds
-- Recast Time: 26 seconds
-- Skillchain Element(s): Water (can open Impaction and Induration can close Reverberation and Fragmentation)
-- Combos: Rapid Shot
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.tpmod = TPMOD_CHANCE
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_REVERBERATION
    params.numhits = 1
    params.multiplier = 1.25
    params.tp150 = 1.25
    params.tp300 = 1.25
    params.azuretp = 1.25
    params.duppercap = 75
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.3
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    -- Missing ENIMITY DOWN

    return damage
end
