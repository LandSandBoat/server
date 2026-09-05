-----------------------------------
-- Spell: Firespit
-- Deals fire damage to an enemy
-- Spell cost: 121 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 5
-- Stat Bonus: STR+3
-- Level: 68
-- Casting Time: 6.5 seconds
-- Recast Time: 42.75 seconds
-- Magic Bursts on: Liquefaction, Fusion, and Light
-- Combos: Conserve MP
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params      = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem  = xi.ecosystem.BEASTMEN
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.FIRE
    params.dStat      = xi.mod.INT

    params.ftp0            = 3.0
    params.dStatMultiplier = 1.5
    params.baseDamageCap   = 69

    params.int_wsc = 0.2
    params.mnd_wsc = 0.2

    return xi.spells.blue.useMagicalSpell(caster, target, spell, params)
end

return spellObject
