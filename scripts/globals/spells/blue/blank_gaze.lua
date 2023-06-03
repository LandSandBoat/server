-----------------------------------
-- Spell: Blank Gaze
-- Removes one beneficial magic effect from an enemy
-- Spell cost: 25 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Light)
-- Blue Magic Points: 2
-- Stat Bonus: None
-- Level: 38
-- Casting Time: 3 seconds
-- Recast Time: 10 seconds
-- Magic Bursts on: Transfixion, Fusion, Light
-- Combos: None
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.BEAST
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.effect = xi.effect.NONE
    local resistThreshold = 0.25
    local effect = xi.effect.NONE

    local resist = applyResistance(caster, target, spell, params)
    if resist >= resistThreshold then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)

        -- Gaze move
        if target:isFacing(caster) and caster:isFacing(target) then
            effect = target:dispelStatusEffect()
            spell:setMsg(xi.msg.basic.MAGIC_ERASE)
            if effect == xi.effect.NONE then
                spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
            end
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return effect
end

return spellObject
