-----------------------------------
-- Spell: Thunderbolt
-- Deals lightning damage to enemies within area of effect. Additional effect: Stun
-- Spell cost: 138 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Thunder)
-- Level: 95
-- Casting Time: 8.5 seconds
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
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.THUNDER
    params.multiplier = 4.0
    params.tMultiplier = 2.0
    params.duppercap = 99
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.3
    params.mnd_wsc = 0.2
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local resist = applyResistance(caster, target, spell, params)
    if (damage > 0 and resist > 0.0625) then
        if (target:canGainStatusEffect(xi.effect.STUN)) then
            target:addStatusEffect(xi.effect.STUN, 1, 3, 5 * resist) -- needs verification
        end
    end

    return damage
end

return spell_object