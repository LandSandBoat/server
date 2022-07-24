-----------------------------------
-- Spell: Heavy Strike
-- Damage varies with TP.
-- Spell cost: 32 MP
-- Monster Type: Arcana
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 2
-- Stat Bonus: STR+2
-- Level: 92
-- Casting Time: 1 seconds
-- Recast Time: 30 seconds
-- Skillchain property: Fragmentation
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
    params.damageType = xi.damageType.BLUNT
    params.scattr = SC_FRAGMENTATION
    params.numhits = 1
    params.multiplier = 2.25
    params.tp150 = 3.5
    params.tp300 = 4.0
    params.azuretp = 4.25 -- ??
    params.duppercap = 99 -- guesstimated crit %s for TP
    params.str_wsc = 0.5
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end

return spell_object
