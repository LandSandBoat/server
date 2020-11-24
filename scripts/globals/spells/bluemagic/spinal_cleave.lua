-----------------------------------------
-- Spell: Spinal Cleave
-- Accuracy varies with TP
-- Spell cost: 61 MP
-- Monster Type: Undead
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 4
-- Stat Bonus: VIT+2, INT+1, MND+1
-- Level: 63
-- Casting Time: 0.5 seconds
-- Recast Time: 28.5 seconds
-- Skillchain Element(s): Earth/Wind (can open Scission, Reverberation, Detonation, Gravitation, or Liquefaction can close Scission or Distortion, Detonation)
-- Combos: Attack Bonus
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
    params.tpmod = TPMOD_ACC
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.SLASHING
    params.scattr = SC_SCISSION
    params.scattr2 = SC_DETONATION
    params.numhits = 1
    params.multiplier = 3.0
    params.tp150 = 3.0
    params.tp300 = 3.0
    params.azuretp = 3.0
    params.duppercap = 75
    params.str_wsc = 0.3
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
