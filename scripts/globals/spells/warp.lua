-----------------------------------
-- Spell: Warp
-- Transports the user to their Home Point
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
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.WARP, 0, 4)
    spell:setMsg(xi.msg.basic.MAGIC_TELEPORT)
    return 0
end

return spell_object
