-----------------------------------
-- Spell: Water Bomb
-- Deals water damage to enemies within area of effect. Additional Effect: Silence
-- Spell cost: 67 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Water)
-- Blue Magic Points: 2
-- Stat Bonus: MP+20 INT+4 MND+2 STR-3 VIT-3
-- Level: 92
-- Casting Time: 3 seconds
-- Recast Time: 32 seconds
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
    params.multiplier = 2.0
    params.tMultiplier = 1.5
    params.duppercap = 99 -- unknown
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.2
    params.mnd_wsc = 0.1
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local resist = applyResistance(caster, target, spell, {
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        effect = xi.effect.SILENCE
    })
    
    if (resist > 0.0625) then
        if (target:canGainStatusEffect(xi.effect.SILENCE)) then
            target:addStatusEffect(xi.effect.SILENCE, 1, 3, 180 * resist)
        end
    end

    return damage
end

return spell_object
