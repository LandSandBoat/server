-----------------------------------
-- Spell: Escape
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    spell:setMsg(xi.msg.basic.MAGIC_TELEPORT)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.ESCAPE, 0, 4)

    return 0
end

return spell_object
