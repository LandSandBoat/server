-----------------------------------
-- Spell: Eyes On Me
-- Deals dark damage to an enemy
-- Spell cost: 112 MP
-- Monster Type: Demons
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: HP-5, MP+15
-- Level: 61
-- Casting Time: 4.5 seconds
-- Recast Time: 29.25 seconds
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: Magic Attack Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params       = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem   = xi.ecosystem.DEMON
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.DARK
    params.dStat       = xi.mod.CHR

    params.ftp0            = 2.625
    params.azureBonus      = 2
    params.dStatMultiplier = 1.5
    params.baseDamageCap    = 69

    params.chr_wsc = 0.4

    return xi.spells.blue.useMagicalSpell(caster, target, spell, params)
end

return spellObject
