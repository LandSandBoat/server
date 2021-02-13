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
    spell:setMsg(tpz.msg.basic.MAGIC_TELEPORT)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.ESCAPE, 0, 4)

    return 0
end

return spell_object
