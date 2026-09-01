-----------------------------------
-- Spell: Rending Deluge
-- Spell cost: 118 MP
-- Monster Type: Aquans
-- Spell Type: Magical (Water)
-- Blue Magic Points: 6
-- Stat Bonus: VIT+6
-- Level: 99
-- Casting Time: 2 seconds
-- Recast Time: 35 seconds
-- Magic Bursts on:
-- Combos: Magic Defense Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params       = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem   = xi.ecosystem.AQUAN
    params.attackType  = xi.attackType.MAGICAL
    params.damageType  = xi.damageType.WATER
    params.dStat       = xi.mod.INT

    local multi = 1.0

    if params.hasAzureLore then
        multi = multi + 1.50
    end

    params.ftp0            = multi
    params.dStatMultiplier = 3.5
    params.baseDamageCap   = 100

    params.str_wsc = 0.2
    params.vit_wsc = 0.2

    local maccParams =
    {
        effectId       = xi.effect.NONE,
        magicalElement = spell:getElement(),
        actorStat      = xi.mod.INT,
        skillType      = xi.skill.BLUE_MAGIC,
        spellGroup     = spell:getSpellGroup(),
    }

    local resist = xi.combat.magicHitRate.calculateResistRate(caster, target, maccParams)

    if resist >= 0.5 then
        target:dispelStatusEffect()
    end

    return xi.spells.blue.useMagicalSpell(caster, target, spell, params)
end

return spellObject
