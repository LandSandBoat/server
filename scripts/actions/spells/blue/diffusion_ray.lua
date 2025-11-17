-----------------------------------
-- Spell: Diffusion Ray
-- Deals light damage to enemies within a fan-shaped area
-- Spell cost: 238 MP
-- Monster Type: Arcana (Chariot)
-- Spell Type: Magical (Light)
-- Blue Magic Points: 6
-- Stat Bonus: STR+5, VIT+7
-- Level: 99
-- Casting Time: 4.5 seconds
-- Recast Time: 45 seconds
-----------------------------------
-- Combos: Store TP
-----------------------------------
-- Notes: High-power AoE light damage spell
-- Formula: WSC 40% MND, fTP 5.0
-- Fan-shaped AoE (conal)
-- Learned from Chariot-type monsters
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.ARCANA
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.LIGHT
    params.diff = 0
    params.skillType = xi.skill.BLUE_MAGIC
    params.multiplier = 5.0  -- High fTP
    params.tMultiplier = 2.0
    params.duppercap = 75
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.4  -- 40% MND
    params.chr_wsc = 0.0
    params.isConal = true

    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    return damage
end

return spellObject
