-----------------------------------
-- Spell: Dispelga
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local params = {}
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    local resist = applyResistance(caster, target, spell, params)
    local effect = xi.effect.NONE

    if (resist > 0.0625) then
        spell:setMsg(xi.msg.basic.MAGIC_ERASE)
        effect = target:dispelStatusEffect()
        if (effect == xi.effect.NONE) then
            -- no effect
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return effect
end

return spell_object
