-----------------------------------
-- Spell: Amorphic Spikes
-- Delivers a fivefold attack. Damage varies with TP.
-- Spell cost: 79 MP
-- Monster Type: Amorphs
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 4
-- Stat Bonus: INT+5 MND+5
-- Level: 98
-- Casting Time: 0.5 seconds
-- Recast Time: 60 seconds
-- Skillchain property: Gravitation
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
    params.scattr = SC_GRAVITATION
    params.numhits = 5
    params.multiplier = 1.0
    params.tp150 = 1.375
    params.tp300 = 1.750
    params.azuretp = 1.8 -- ??
    params.duppercap = 99 -- guesstimated crit %s for TP
    params.str_wsc = 0.0
    params.dex_wsc = 0.2
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.2
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end

return spell_object
