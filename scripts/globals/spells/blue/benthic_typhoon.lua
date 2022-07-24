-----------------------------------
-- Spell: Benthic Typhoon
-- Delivers an area attack that lowers target's defense and magic defense. Damage varies with TP
-- Spell cost: 56 MP
-- Monster Type: Arcana
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: STR+2 VIT+2 DEX-1 AGI-1
-- Level: 83
-- Casting Time: 0.5 seconds
-- Recast Time: 55 seconds
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
    params.damageType = xi.damageType.PIERCING
    params.scattr = SC_GRAVITATION
    params.numhits = 1
    params.multiplier = 4.0
    params.tp150 = 4.5
    params.tp300 = 5.0
    params.azuretp = 5.25
    params.duppercap = 99
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.6
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local resist = applyResistanceEffect(caster, target, spell, {
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        bonus = 0,
        effect = xi.effect.DEFENSE_DOWN
    })

    local resistb = applyResistanceEffect(caster, target, spell, {
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        bonus = 0,
        effect = xi.effect.MAGIC_DEF_DOWN
    })

    if (resist > 0.5) then -- This line may need adjusting for retail accuracy.
        target:addStatusEffect(xi.effect.DEFENSE_DOWN, 10, 3, 60 * resist) -- pre-resist duration needs confirmed/adjusted
    end

    if (resistb > 0.5) then -- This line may need adjusting for retail accuracy.
        target:addStatusEffect(xi.effect.MAGIC_DEF_DOWN, 10, 3, 60 * resist) -- pre-resist duration needs confirmed/adjusted
    end

    return damage
end

return spell_object
