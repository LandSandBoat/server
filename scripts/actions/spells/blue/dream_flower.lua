-----------------------------------
-- Spell: Dream Flower
-- Puts all enemies within range to sleep
-- Spell cost: 68 MP
-- Monster Type: Plantoid
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 3
-- Stat Bonus: HP+5 MP+5 CHR+2
-- Level: 87
-- Casting Time: Casting Time: 2.5 seconds
-- Recast Time: Recast Time: 45 seconds
-- Duration: 90~120 seconds
-- Magic Bursts on: None
-- Combos: Magic Attack Bonus
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem       = xi.ecosystem.PLANTOID
    params.effect          = xi.effect.SLEEP_I -- https://wiki.ffo.jp/html/5502.html
    params.power           = 1
    params.tick            = 0
    params.duration        = 90 -- https://wiki.ffo.jp/html/5502.html says the duration might be reduced based on number of targets. Might need to be fixed in the future
    params.resistThreshold = 0.50
    params.isGaze          = false
    params.isConal         = false

    return xi.spells.blue.useEnfeeblingSpell(caster, target, spell, params)
end

return spellObject
