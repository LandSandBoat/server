-----------------------------------
-- Spell: Everyone's Grudge
-- Deals dark damage to a single target
-- Spell cost: 185 MP
-- Monster Type: Beastmen (Tonberry)
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: INT+2, MND+2, STR-1, VIT-1
-- Level: 90
-- Casting Time: 5.5 seconds
-- Recast Time: 70 seconds
-----------------------------------
-- Combos: Gilfinder, Treasure Hunter
-----------------------------------
-- Notes: PROXY FORMULA: Based on Dark Orb (high-power dark magical nuke)
-- Primary stat: 40% MND
-- Magic Burst: Compression, Gravitation, Darkness
-- Distance: 21.5 yalms
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- PROXY: Using Dark Orb formula (high-power magical nuke)
    local params = {}
    params.ecosystem = xi.ecosystem.BEASTMAN
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.DARK
    params.diff = 0
    params.skillType = xi.skill.BLUE_MAGIC
    params.multiplier = 4.5
    params.tMultiplier = 2.0
    params.duppercap = 75
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.4  -- 40% MND
    params.chr_wsc = 0.0

    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    return damage
end

return spellObject
