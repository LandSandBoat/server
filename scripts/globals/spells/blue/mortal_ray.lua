-----------------------------------
-- Spell: Mortal Ray
-- Inflicts Doom upon an enemy
-- Spell cost: 267 MP
-- Monster Type: Demons
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: STR+2 MND+2
-- Level: 91
-- Casting Time: 8 seconds
-- Recast Time: 150 seconds
-- Duration: 63 seconds
-- Gaze
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
        if (target:isFacing(caster)) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
            target:addStatusEffect(effect, 63, 3, 0)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return effect
end

return spell_object
