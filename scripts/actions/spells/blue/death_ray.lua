-----------------------------------
-- Spell: Death Ray
-- Deals dark damage to an enemy
-- Spell cost: 49 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 2
-- Stat Bonus: HP-5, MP+5
-- Level: 34
-- Casting Time: 4.5 seconds
-- Recast Time: 29.25 seconds
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: None
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params      = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem  = xi.ecosystem.AMORPH
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.DARK
    params.dStat      = xi.mod.INT

    params.ftp0            = 1.625
    params.azureBonus      = 2
    params.dStatMultiplier = 1.0
    params.baseDamageCap   = 51

    params.int_wsc = 0.2
    params.mnd_wsc = 0.1

    return xi.spells.blue.useMagicalSpell(caster, target, spell, params)
end

return spellObject
