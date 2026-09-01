-----------------------------------
-- Spell: Body Slam
-- Delivers an area attack. Damage varies with TP
-- Spell cost: 74 MP
-- Monster Type: Dragon
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: VIT+1, MP+5
-- Level: 62
-- Casting Time: 1 seconds
-- Recast Time: 27.75 seconds
-- Skillchain Element(s): Impaction
-- Combos: Max HP Boost
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params          = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem      = xi.ecosystem.DRAGON
    params.tpModifier     = xi.spells.blue.tpMod.ATTACK
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.skillchainType = xi.skillchainType.IMPACTION

    params.numHits       = 1
    params.ftp0          = 1.5
    params.ftp1500       = 1.5
    params.ftp3000       = 1.5
    params.ftpAzure      = 1.5
    params.baseDamageCap = 999 -- uncapped
    params.attackMult    = 1.3

    if params.hasAzureLore then
        params.attackMult = 2.15
    elseif params.hasChainAffinity then
        params.attackMult = xi.spells.blue.calculatefTP(caster:getTP(), 1.3, 1.7, 2.10)
    end

    params.vit_wsc = 0.4

    return xi.spells.blue.usePhysicalSpell(caster, target, spell, params)
end

return spellObject
