-----------------------------------
-- Spell: Wind Breath
-- Deals Wind breath damage to enemies within a fan-shaped area originating from the caster.
-- Spell cost: 26 MP
-- Monster Type: Dragons
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 2
-- Stat Bonus: STR+2 AGI+2
-- Level: 99
-- Casting Time: 1.5 seconds
-- Recast Time: 29.5 seconds
-- Magic Bursts on: None
-- Combos: Fast Cast
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem  = xi.ecosystem.DRAGON
    params.attackType = xi.attackType.BREATH
    params.damageType = xi.damageType.WIND
    params.diff       = 0 -- no stat increases magic accuracy
    params.skillType  = xi.skill.BLUE_MAGIC
    params.hpMod      = 4
    params.lvlMod     = 0
    params.isConal    = true

    return xi.spells.blue.useBreathSpell(caster, target, spell, params)
end

return spellObject
