-----------------------------------
-- Spell: Tractor
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if
        target:isMob() or                             -- Because Prishe in CoP mission.
        target:isAlive() or                           -- Can't cast on alive targets.
        target:hasRaiseTractorMenu() or               -- Raise and tractor menus both block the casting.
        target:hasStatusEffect(xi.effect.BATTLEFIELD) -- Cannot be cast on BCNMs.
    then
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
