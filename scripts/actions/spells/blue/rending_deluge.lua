-----------------------------------
-- Spell: Rending Deluge
-- Spell cost: 118 MP
-- Monster Type: Aquans
-- Spell Type: Magical (Water)
-- Blue Magic Points: 6
-- Stat Bonus: VIT+6
-- Level: 99
-- Casting Time: 2 seconds
-- Recast Time: 35 seconds
-- Magic Bursts on:
-- Combos: Magic Defense Bonus
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local multi = 1.0
    if caster:hasStatusEffect(xi.effect.AZURE_LORE) then
        multi = multi + 1.50
    end

    local params = {}
    params.ecosystem = xi.ecosystem.AQUAN
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.WATER
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.effect = xi.effect.NONE
    params.multiplier = multi
    params.tMultiplier = 3.5
    params.duppercap = 100
    params.str_wsc = 0.2
    params.dex_wsc = 0.0
    params.vit_wsc = 0.2
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local resist = applyResistance(caster, target, spell, params)
    if resist > 0.0625 then
        target:dispelStatusEffect()
    end

    return xi.spells.blue.useMagicalSpell(caster, target, spell, params)
end

return spellObject
