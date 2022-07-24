-----------------------------------
-- NEEDS VALIDATION
-- Spell: Thunder Breath
-- Deals thunder breath damage to enemies within a fan-shaped area originating from the caster
-- Spell cost: 193 MP
-- Monster Type: Dragons
-- Spell Type: Magical (Thunder)
-- Blue Magic Points: 4
-- Stat Bonus: STR+2 DEX+2
-- Level: 97
-- Casting Time: 7 seconds
-- Recast Time: 56 seconds
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
    local multi = 6.38
    if (caster:hasStatusEffect(xi.effect.AZURE_LORE)) then
        multi = multi + 0.50
    end
    
    local params = {}
    params.diff = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.bonus = 1.0
    -- local resist = applyResistance(caster, target, spell, params)
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.THUNDER
    params.multiplier = multi
    params.tMultiplier = 1.5
    params.duppercap = 99
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.3
    params.chr_wsc = 0.0
    local damage = BlueMagicalSpell(caster, target, spell, params, MND_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end

return spell_object
