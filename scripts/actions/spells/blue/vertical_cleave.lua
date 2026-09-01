-----------------------------------
-- Spell: Vertical Cleave
-- Damage varies with TP
-- Spell cost: 86 MP
-- Monster Type: Luminians
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+1 HP-5 MP+5
-- Level: 75
-- Casting Time: 0.5 seconds
-- Recast Time: 37.25 seconds
-- Skillchain Element(s): Gravitation
-- Combos: Defense Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params          = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem      = xi.ecosystem.LUMINIAN
    params.tpModifier     = xi.spells.blue.tpMod.ATTACK
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.skillchainType = xi.skillchainType.GRAVITATION

    params.numHits       = 1
    params.ftp0          = 3.0
    params.ftp1500       = 3.0
    params.ftp3000       = 3.0
    params.ftpAzure      = 3.0
    params.baseDamageCap = 89
    params.attackMult    = 1.05

    if params.hasAzureLore then
        params.attackMult = 2.25
    elseif params.hasChainAffinity then
        params.attackMult = xi.spells.blue.calculatefTP(caster:getTP(), 1.05, 2.1, 2.2)
    end

    params.str_wsc = 0.5

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
