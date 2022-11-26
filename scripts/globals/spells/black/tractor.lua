-----------------------------------
-- Spell: Tractor
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if target:isMob() then -- Because Prishe in CoP mission
        return xi.msg.basic.CANNOT_ON_THAT_TARG
    end

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:getObjType() == xi.objType.PC then
        target:sendTractor(caster:getXPos(), caster:getYPos(), caster:getZPos(), target:getRotPos())
        spell:setMsg(xi.msg.basic.MAGIC_CASTS_ON)
        return 1
    end

    return 0
end

return spellObject
