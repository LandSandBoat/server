-----------------------------------
-- Spell: Bomb Toss
-- Throws a bomb at an enemy
-- Spell cost: 42 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 3
-- Stat Bonus: STR+2
-- Level: 28
-- Casting Time: 3.75 seconds
-- Recast Time: 24.5 seconds
-- Magic Bursts on: Liquefaction, Fusion, Light
-- Combos: None
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

    params.ftp0            = 1.625
    params.dStatMultiplier = 1.0
    params.baseDamageCap   = 40
    params.int_wsc         = 0.2

    return xi.spells.blue.useMagicalSpell(caster, target, spell, params)
end

return spellObject
