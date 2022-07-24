-----------------------------------
-- Spell: Quad. Continuum
-- Delivers a fourfold attack. Damage varies with TP.
-- Spell cost: 91 MP
-- Monster Type: Empty
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 4
-- Stat Bonus: DEX+3 CHR-2
-- Level: 85
-- Casting Time: 1 seconds
-- Recast Time: 31.75 seconds
-- Skillchain property: Distortion
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
    params.tpmod = TPMOD_DAMAGE
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.PIERCING
    params.scattr = SC_DISTORTION
    params.numhits = 4
    params.multiplier = 1.25
    params.tp150 = 1.5
    params.tp300 = 1.75
    params.azuretp = 2.0
    params.duppercap = 99
    params.str_wsc = 0.32
    params.dex_wsc = 0.0
    params.vit_wsc = 0.32
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end

return spell_object
