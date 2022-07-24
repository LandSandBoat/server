-----------------------------------
-- Spell: Quadrastrike
-- Delivers a fourfold attack. Chance of critical hit varies with TP.
-- Spell cost: 98 MP
-- Monster Type: Demons
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 5
-- Stat Bonus: STR+3 CHR+3
-- Level: 96
-- Casting Time: 4 seconds
-- Recast Time: 42.5 seconds
-- Skillchain property: Liquifaction
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local params = {}
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.tpmod = TPMOD_CRITICAL
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.scattr = SC_LIQUEFACTION
    params.numhits = 4
    params.multiplier = 1.1875
    params.tp150 = 1.1875
    params.tp300 = 1.1875
    params.azuretp = 1.1875
    params.duppercap = 99
    params.str_wsc = 0.3
    params.dex_wsc = 0.0
    params.vit_wsc = 0.3
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.offcratiomod = caster:getStat(xi.mod.ATT) * 1.25 -- 25% attack bonus
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end

return spell_object
