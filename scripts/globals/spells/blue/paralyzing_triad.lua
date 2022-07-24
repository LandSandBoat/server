-----------------------------------
-- Spell: Paralyzing Triad
-- Delivers a threefold attack. Additional Effect: Paralysis. Damage varies with TP.
-- Spell cost: 33 MP
-- Monster Type: Elemental
-- Spell Type: Physical (Slashing)
-- Level: 99
-- Casting Time: 1 seconds
-- Recast Time: 15 seconds
-- Skillchain Element(s): Gravitation
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
    params.scattr = SC_GRAVITATION
    params.numhits = 3
    params.multiplier = 1.125
    params.tp150 = 1.125
    params.tp300 = 1.125
    params.azuretp = 2.0
    params.duppercap = 99 -- unknown
    params.str_wsc = 0.3
    params.dex_wsc = 0.3
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
        effect = xi.effect.PARALYSIS
    })
    if (resist > 0.0625) then
        if (target:canGainStatusEffect(xi.effect.PARALYSIS)) then
            target:addStatusEffect(xi.effect.PARALYSIS, 20, 0, 60 * resist)
        end
    end

    return damage
end

return spell_object