-----------------------------------
-- Spell: Dark Orb
-- Deals dark damage to an enemy
-- Spell cost: 124 MP
-- Monster Type: Demons
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 3
-- Stat Bonus: AGI+2 MND+2
-- Level: 93
-- Casting Time: 9 seconds
-- Recast Time: 72 second
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
    local multi = 4.5
    if (caster:hasStatusEffect(xi.effect.AZURE_LORE)) then
        multi = multi + 2.0
    end
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.DARK
    params.multiplier = multi
    params.tMultiplier = 2.0
    params.duppercap = 99
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.4
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end

return spell_object
