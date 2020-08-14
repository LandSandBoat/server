-----------------------------------------
-- Spell: Warp
-- Transports the user to their Home Point
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.WARP, 0, 4)
    spell:setMsg(tpz.msg.basic.MAGIC_TELEPORT)
    return 0
end
