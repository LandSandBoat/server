-----------------------------------
-- Spell: Sinker Drill
-- Delivers a fivefold attack. Damage varies with TP.
-- Spell Type: Physical (Piercing)
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
    params.tpmod = TPMOD_CRITICAL
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.PIERCING
    params.scattr = SC_GRAVITATION
    params.numhits = 5
    params.multiplier = 1.0
    params.tp150 = 1.25 -- ??
    params.tp300 = 1.5 -- ??
    params.azuretp = 1.75 -- ??
    params.duppercap = 99
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
