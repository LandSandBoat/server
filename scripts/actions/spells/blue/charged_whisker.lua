-----------------------------------
-- Spell: Charged Whisker
-- Deals Lightning damage to enemies within area of effect.
-- Spell cost: 183 MP
-- Monster Type: Beast
-- Spell Type: Magical (Lightning)
-- Blue Magic Points: 4
-- Stat Bonus: HP-10 DEX+2 INT+2
-- Level: 88
-- Casting Time: 5 seconds
-- Recast Time: 85 seconds
-- Magic Bursts on: Reverberation, Distortion, and Darkness
-- Combos: Gilfinder, Treasure Hunter
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem   = xi.ecosystem.BEAST
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.THUNDER
    params.attribute   = xi.mod.INT
    params.multiplier  = 2.0
    params.tMultiplier = 4.5
    params.duppercap   = 100
    params.str_wsc     = 0.0
    params.dex_wsc     = 0.5
    params.vit_wsc     = 0.0
    params.agi_wsc     = 0.0
    params.int_wsc     = 0.0
    params.mnd_wsc     = 0.0
    params.chr_wsc     = 0.0

    -- Handle damage.
    local damage = xi.spells.blue.useMagicalSpell(caster, target, spell, params)

    return damage
end

return spellObject
