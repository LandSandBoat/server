-----------------------------------
-- Spell: Vanity Dive
-- Damage varies with TP
-- Spell cost: 58 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 2
-- Stat Bonus: AGI+3, CHR -2
-- Level: 82
-- Casting Time: 0.5 seconds
-- Recast Time: 40 seconds
-- Skillchain Element(s): Scission
-- Combos: None
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
    params.damageType = xi.damageType.SLASHING
    params.scattr = SC_SCISSION
    params.numhits = 1
    params.multiplier = 3
    params.tp150 = 4
    params.tp300 = 4
    params.azuretp = 4.75
    params.duppercap = 99 -- unknown
    params.str_wsc = 0.0
    params.dex_wsc = 0.5
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.offcratiomod = caster:getStat(xi.mod.ATT) * 1.66 -- 66% attack boost
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end

return spell_object
