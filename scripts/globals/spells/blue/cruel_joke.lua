-----------------------------------
-- Spell: Curel Joke
-- Inflicts Doom upon enemies within range
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local params = {}
    local effect = xi.effect.DOOM

    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC

    if not target:canGainStatusEffect(xi.effect.DOOM) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return effect
    end

    local resist = applyResistance(caster, target, spell, params)
    

    if (resist > 0.0625) then
        if (target:canGainStatusEffect(effect)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
            target:addStatusEffect(effect, 60, 3, 0)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return effect
end

return spell_object