-----------------------------------------
-- Spell: Sub-zero Smash
-- Additional Effect: Paralysis. Damage varies with TP
-- Spell cost: 44 MP
-- Monster Type: Aquans
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: HP+10 VIT+3
-- Level: 72
-- Casting Time: 1 second
-- Recast Time: 30 seconds
-- Skillchain Element(s): Fragmentation-IconFragmentation (can open/close Light-Icon Light with Fusion WSs and spells)
-- Combos: Fast Cast
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
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_FRAGMENTATION
    params.numhits = 1
    params.multiplier = 1.95
    params.tp150 = 1.25
    params.tp300 = 1.25
    params.azuretp = 1.25
    params.duppercap = 72
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.20
    params.mnd_wsc = 0.3
    params.chr_wsc = 0.0
    damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local chance = math.random(1, 20)

    if (damage > 0 and chance > 5) then
        local typeEffect = tpz.effect.PARALYSIS
        target:delStatusEffect(typeEffect)
        target:addStatusEffect(typeEffect, 1, 0, getBlueEffectDuration(caster, resist, typeEffect))
    end

    return damage
end
