-----------------------------------
-- Spell: Enervation
-- Lowers the defense and magical defense of enemies within range
-- Spell cost: 48 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 5
-- Stat Bonus: HP-5, MP+5
-- Level: 67
-- Casting Time: 6 seconds
-- Recast Time: 60 seconds
-- Magic Bursts on: Compression, Gravitation, and Darkness
-- Combos: Counter
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local typeEffectOne = xi.effect.DEFENSE_DOWN
    local typeEffectTwo = xi.effect.MAGIC_DEF_DOWN
    local params = {}
    params.ecosystem = xi.ecosystem.BEASTMEN
    params.effect = typeEffectOne
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    local duration = 30
    local resistThreshold = 0.5
    local returnEffect = typeEffectOne

    local resist = applyResistance(caster, target, spell, params)
    if resist >= resistThreshold then

        local actionOne = target:addStatusEffect(typeEffectOne, 10, 0, duration * resist)
        local actionTwo = target:addStatusEffect(typeEffectTwo, 8, 0, duration * resist)

        -- If at least one of effects got applied, set the message type
        if actionOne or actionTwo then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        end

        -- Set the returnEffect to effectTwo if the first one failed
        if not actionOne and actionTwo then
            returnEffect = typeEffectTwo
        end

    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return returnEffect
end

return spellObject
