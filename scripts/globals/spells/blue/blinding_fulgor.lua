-----------------------------------
-- Spell: Blinding Fulgor
-- Deals light damage to enemies within area of effect. Additional effect: Flash
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
    params.damageType = xi.damageType.LIGHT
    params.multiplier = 4.0
    params.tMultiplier = 2.0
    params.duppercap = 99 -- unknown
    params.str_wsc = 0.3
    params.dex_wsc = 0.3
    params.vit_wsc = 0.0
    params.agi_wsc = 0.3
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    local resist = applyResistance(caster, target, spell, {
        attribute = xi.mod.INT,
        skillType = xi.skill.BLUE_MAGIC,
        effect = xi.effect.FLASH
    })
    if (resist > 0.0625) then
        if (target:canGainStatusEffect(xi.effect.FLASH)) then
            target:addStatusEffect(xi.effect.FLASH, 200, 0, 15 * resist)
        end
    end

    return damage
end

return spell_object
