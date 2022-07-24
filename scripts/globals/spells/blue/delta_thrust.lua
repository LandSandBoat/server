-----------------------------------
-- Spell: Delta Thrust
-- Delivers a threefold attack. Additional effect: Plague
-- Spell cost: 28 MP
-- Monster Type: Lizards
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: HP+15 MP-5 INT-1
-- Level: 89
-- Casting Time: 0.5 seconds
-- Recast Time: 15 seconds
-- Skillchain Element(s): Fire (can open Scission or Fusion can close Liquefaction)
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
    params.scattr = SC_LIQUEFACTION
    params.numhits = 3
    params.multiplier = 1.09375
    params.azuretp = 1.09375
    params.duppercap = 99
    params.str_wsc = 0.2
    params.dex_wsc = 0.0
    params.vit_wsc = 0.5
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local resist = applyResistance(caster, target, spell, {
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        effect = xi.effect.PLAGUE
    })
    if (resist > 0.0625) then
        if (target:canGainStatusEffect(xi.effect.PLAGUE)) then
            target:addStatusEffect(xi.effect.PLAGUE, 10, 3, 120)
        end
    end

    return damage
end

return spell_object
