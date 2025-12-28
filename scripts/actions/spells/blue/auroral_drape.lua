-----------------------------------
-- Spell: Auroral Drape
-- Silences and blinds enemies within range.
-- Spell cost: 51 MP
-- Monster Type: Empty
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: INT+3 CHR-2
-- Level: 84
-- Casting Time: Casting Time: 4 seconds
-- Recast Time: Recast Time: 60 seconds
-- Duration: 40-60 seconds
-- Magic Bursts on: None
-- Combos: Fast Cast
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem       = xi.ecosystem.EMPTY
    params.effect          = xi.effect.SILENCE
    params.power           = 1
    params.tick            = 0
    params.duration        = 60
    params.resistThreshold = 0.50
    params.isGaze          = false
    params.isConal         = false

    local resist = xi.combat.magicHitRate.calculateResistRate(caster, target, spell:getSpellGroup(), xi.skill.BLUE_MAGIC, 0, spell:getElement(), xi.mod.INT, 0, 0)

    -- Handle status effects.
    -- Not sure if there's a better way to implement both status effects
    local effectTable =
    {
        [1] = { xi.effect.BIND, 25, 0, 40 + math.floor(resist * 20) },
    }

    xi.spells.blue.applyBlueAdditionalEffect(caster, target, params, effectTable)

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params)
end

return spellObject
