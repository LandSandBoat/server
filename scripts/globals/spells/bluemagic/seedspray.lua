-----------------------------------------
-- Spell: Seedspray
-- Delivers a threefold attack. Additional effect: Weakens defense. Chance of effect varies with TP
-- Spell cost: 61 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: VIT+1
-- Level: 61
-- Casting Time: 4 seconds
-- Recast Time: 35 seconds
-- Skillchain Element(s): Ice (Primary) and Wind (Secondary) - (can open Impaction, Compression, Fragmentation, Scission or Gravitation can close Induration or Detonation)
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
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.SLASHING
    params.scattr = SC_GRAVITATION
    params.numhits = 3
    params.multiplier = 1.925
    params.tp150 = 1.25
    params.tp300 = 1.25
    params.azuretp = 1.25
    params.duppercap = 61
    params.str_wsc = 0.0
    params.dex_wsc = 0.30
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.20
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local chance = math.random()

    if (damage > 0 and chance > 1) then
        local typeEffect = tpz.effect.DEFENSE_DOWN
        target:delStatusEffect(typeEffect)
        target:addStatusEffect(typeEffect, 4, 0, getBlueEffectDuration(caster, resist, typeEffect))
    end

    return damage
end
