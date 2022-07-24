-----------------------------------
-- Spell: Bloodrake
-- Delivers a threefold attack. Damage varies with TP. Additional effect: HP Drain
-- Spell cost: 99 MP
-- Monster Type: Undead
-- Spell Type: Physical (Slashing)
-- Level: 99
-- Casting Time: 0.5 seconds
-- Recast Time: 30 seconds
-- Skillchain Element(s): Darkness / Distortion
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
    params.attackType = xi.attackType.PHYSICAL
    params.damageType = xi.damageType.SLASHING
    params.scattr = SC_DARKNESS
    params.numhits = 3
    params.multiplier = 1.0
    params.tp150 = 1.1375
    params.tp300 = 2.75
    params.azuretp = 3.0
    params.duppercap = 99
    params.str_wsc = 0.3
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.3
    params.chr_wsc = 0.0
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    if (target:isUndead() == false) then
        caster:addHP(damage)
    end

    return damage
end

return spell_object
