-----------------------------------
-- Spell: Whirl of Rage
-- Delivers an area attack that stuns enemies. Damage varies with TP
-- Spell cost: 73 MP
-- Monster Type: Arcana
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: VIT+1
-- Level: 83
-- Casting Time: 1 seconds
-- Recast Time: 30 seconds
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
    params.multiplier = 3.0
    params.tp150 = 4.0
    params.tp300 = 4.0
    params.azuretp = 4.25
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

    local resist = applyResistanceEffect(caster, target, spell, {
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        bonus = 0,
        effect = xi.effect.STUN
    })

    if (resist > 0.5) then -- This line may need adjusting for retail accuracy.
        target:addStatusEffect(xi.effect.STUN, 1, 3, 5 * resist) -- pre-resist duration needs confirmed/adjusted
    end

    return damage
end

return spell_object
