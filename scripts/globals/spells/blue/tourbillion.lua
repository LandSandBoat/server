-----------------------------------
-- Spell: Tourbillion
-- Delivers an area attack. Additional effect duration varies with TP. Additional effect: Weakens defense.
-- Spell cost: 108 MP
-- Monster Type: Arcana
-- Spell Type: Physical (Blunt)
-- Level: 97
-- Casting Time: 1 seconds
-- Recast Time: 30 seconds
-- Skillchain Element(s): Light / Fragmentation
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
    params.scattr = SC_LIGHT
    params.numhits = 1
    params.multiplier = 4.0
    params.duppercap = 99 -- unknown
    params.str_wsc = 0.25
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.25
    params.chr_wsc = 0.0
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local resist = applyResistance(caster, target, spell, {
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        effect = xi.effect.DEFENSE_DOWN
    })
    if (resist > 0.0625) then
        if (target:canGainStatusEffect(xi.effect.DEFENSE_DOWN)) then
            target:addStatusEffect(xi.effect.BURN, 33, 3, 120 * resist)
        end
    end

    return damage
end

return spell_object
