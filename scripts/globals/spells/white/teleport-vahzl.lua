-----------------------------------
-- Spell: Teleport-Vahzl
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/keyitems")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    if target:getObjType() == xi.objType.PC then
        if target:hasKeyItem(xi.ki.VAHZL_GATE_CRYSTAL) then
            target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.VAHZL, 0, 4.7)
            spell:setMsg(xi.msg.basic.MAGIC_TELEPORT)
        else
            spell:setMsg(xi.msg.basic.NONE)
        end
    end
    return 0
end

return spell_object
