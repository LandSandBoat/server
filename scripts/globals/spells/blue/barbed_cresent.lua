-----------------------------------
-- Spell: Barbed Crescent
-- Damage varies with TP. Additional effect: Accuracy Down
-- Spell cost: 52 MP
-- Monster Type: Undead
-- Spell Type: Physical (Slashing)
-- Level: 99
-- Casting Time: 0.5 seconds
-- Recast Time: 22 seconds
-- Skillchain Element(s): Distortion / Liquefaction
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
    params.scattr = SC_DISTORTION
    params.numhits = 1
    params.multiplier = 2.0
    params.duppercap = 99 -- unknown
    params.str_wsc = 0.0
    params.dex_wsc = 0.5
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local resist = applyResistance(caster, target, spell, {
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        effect = xi.effect.ACCURACY_DOWN
    })
    if (resist > 0.0625) then
        if (target:canGainStatusEffect(xi.effect.ACCURACY_DOWN)) then
            target:addStatusEffect(xi.effect.ACCURACY_DOWN, 30, 3, 120 * resist)
        end
    end

    return damage
end

return spell_object
