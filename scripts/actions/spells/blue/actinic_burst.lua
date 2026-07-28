-----------------------------------
-- Spell: Actinic Burst
-- Greatly lowers the accuracy of enemies within range for a brief period of time
-- Spell cost: 24 MP
-- Monster Type: Luminions
-- Spell Type: Magical (Light)
-- Blue Magic Points: 4
-- Stat Bonus: CHR+2, HP+20
-- Level: 74
-- Casting Time: 0.5 seconds
-- Recast Time: 60 seconds
-- Effect Time: About 15 seconds
-- Magic Bursts on: Transfixion, Fusion, and Light
-- Combos: Auto Refresh
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params =
    {
        effectId       = xi.effect.FLASH,
        power          = 0,
        duration       = 12,
        tier           = 1,
        magicalElement = xi.element.LIGHT,
        actorStat      = xi.mod.MND,
        skillType      = xi.skill.BLUE_MAGIC,
        spellGroup     = xi.magic.spellGroup.BLUE,
        ecosystem      = xi.ecosystem.LUMINION,
        bonusMacc      = 512,
        fealty         = true,
    }

    return xi.combat.action.executeSpellEnfeeblement(caster, target, spell, params)
end

return spellObject
