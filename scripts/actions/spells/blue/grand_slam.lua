-----------------------------------
-- Spell: Grand Slam
-- Delivers an area attack. Damage varies with TP
-- Spell cost: 24 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 2
-- Stat Bonus: INT+1
-- Level: 30
-- Casting Time: 1 seconds
-- Recast Time: 14.25 seconds
-- Skillchain Element(s): Induration
-- Combos: Defense Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params          = xi.spells.blue.getDefaultParams(caster)
    params.tpModifier     = xi.spells.blue.tpMod.ATTACK
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.HAND_TO_HAND
    params.skillchainType = xi.skillchainType.INDURATION

    params.numHits       = 1
    params.ftp0          = 1.0
    params.ftp1500       = 1.0
    params.ftp3000       = 1.0
    params.ftpAzure      = 1.0
    params.baseDamageCap = 33

    params.vit_wsc = 0.3

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
