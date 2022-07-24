-----------------------------------
-- Spell: Acrid Stream
-- Deals water damage to enemy. Additional Effect: Lowers target's Magic Defense
-- Spell cost: 89 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Water)
-- Blue Magic Points: 3
-- Stat Bonus: DEX+2 MND+2
-- Level: 77
-- Casting Time: 4 seconds
-- Recast Time: 23 seconds
-- Combos: Conserve MP
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
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.WATER
    params.multiplier = 3.0
    params.tMultiplier = 2.0
    params.duppercap = 94 -- unknown
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.3
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local resist = applyResistance(caster, target, spell, {
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        effect = xi.effect.MAGIC_DEF_DOWN
    })
    if (resist > 0.0625) then
        if (target:canGainStatusEffect(xi.effect.MAGIC_DEF_DOWN)) then
            target:addStatusEffect(xi.effect.MAGIC_DEF_DOWN, 10, 3, 120)
        end
    end

    return damage
end

return spell_object
