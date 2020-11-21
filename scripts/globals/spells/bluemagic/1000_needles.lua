-----------------------------------------
-- Spell: 1000 Needles
-- Shoots multiple needles at enemies within range
-- Spell cost: 350 MP
-- Monster Type: Plantoid
-- Spell Type: Magical (Light)
-- Blue Magic Points: 5
-- Stat Bonus: VIT+3, AGI+3
-- Level: 62
-- Casting Time: 12 seconds
-- Recast Time: 120 seconds
-- Bursts on Light affects accuracy only
-- Combos: Beast Killer
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
        params.tpmod = TPMOD_CRITICAL
        params.attackType = tpz.attackType.MAGICAL
        params.damageType = tpz.damageType.LIGHT
        params.scattr = SC_COMPRESSION
        params.numhits = 1
        params.multiplier = 1.5
        params.tp150 = 1.5
        params.tp300 = 1.5
        params.azuretp = 1.5
        params.duppercap = 49
        params.str_wsc = 1.0
        params.dex_wsc = 1.5
        params.vit_wsc = 0.0
        params.agi_wsc = 0.0
        params.int_wsc = 2.0
        params.mnd_wsc = 1.0
        params.chr_wsc = 1.0
    damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
