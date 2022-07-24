-----------------------------------
-- Spell: Goblin Rush
-- Delivers a threefold attack. Accuracy varies with TP.
-- Spell cost: 76 MP
-- Monster Type: Beastman
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: HP+10 DEX+2 MND-3
-- Level: 81
-- Casting Time: 0.5 seconds
-- Recast Time: 25.5 seconds
-- Skillchain Element(s): Fusion / Impaction
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
    params.tpmod = TPMOD_ACC
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.BLUNT
    params.scattr = SC_FUSION
    params.numhits = 3
    params.multiplier = 1.0
    params.tp150 = 1.25
    params.tp300 = 1.25
    params.azuretp = 1.2
    params.duppercap = 99 -- unknown
    params.str_wsc = 0.3
    params.dex_wsc = 0.3
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.offcratiomod = caster:getStat(xi.mod.ATT) * 1.35 -- 35% attack boost
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end

return spell_object