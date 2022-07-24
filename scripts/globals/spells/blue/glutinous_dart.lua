-----------------------------------
-- Spell: Glutinous Dart
-- Damage Varies with TP.
-- Spell cost: 16 MP
-- Monster Type: Beastman
-- Spell Type: Physical (PIERCING)
-- Level: 99
-- Casting Time: 1 seconds
-- Recast Time: 6 seconds
-- Skillchain Element(s): Fragmentation
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
    params.scattr = SC_FRAGMENTATION
    params.numhits = 1
    params.multiplier = 1.0
    params.tp150 = 2.0
    params.tp300 = 3.0
    params.azuretp = 3.5
    params.duppercap = 99 -- unknown
    params.str_wsc = 0.5
    params.dex_wsc = 0.0
    params.vit_wsc = 0.5
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end

return spell_object