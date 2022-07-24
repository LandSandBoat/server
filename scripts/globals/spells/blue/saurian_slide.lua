-----------------------------------
-- Spell: Sweeping Gouge
-- Additional Effect: weakens defense. Damage varies with TP.
-- Spell Type: Physical (Slashing)
-- Skillchain Element(s): Fragmentation / Distortion
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
    params.scattr = SC_FRAGMENTATION -- unknown
    params.numhits = 1
    params.multiplier = 1.0
    params.tp150 = 1.0
    params.tp300 = 1.0
    params.azuretp = 1.0
    params.duppercap = 99 -- unknown
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
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
        effect = xi.effect.ATTACK_DOWN
    })
    if (resist > 0.0625) then
        if (target:canGainStatusEffect(xi.effect.ATTACK_DOWN)) then
            target:addStatusEffect(xi.effect.ATTACK_DOWN, 25, 3, 60 * resist)
        end
    end

    return damage
end

return spell_object