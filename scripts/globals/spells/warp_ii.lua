-----------------------------------
-- Spell: Warp II
-- Transports player to their home point. Can cast on allies.
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
    if target:getObjType() == xi.objType.PC then
        target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.WARP, 0, 3.4)
        spell:setMsg(xi.msg.basic.MAGIC_TELEPORT)
    end
    return 0
end

return spell_object
