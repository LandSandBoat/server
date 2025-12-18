-----------------------------------
-- Spell: Raise III
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    -- Can't cast on living targets
    if target:isAlive() then
        return xi.msg.basic.MAGIC_CANNOT_BE_CAST
    end

    -- Only PCs should ever be blocked by the Raise/Tractor menu state
    if target:isPC() and target:hasRaiseTractorMenu() then
        return xi.msg.basic.MAGIC_CANNOT_BE_CAST
    end

    -- Non-PC targets must be explicitly raisable (behavior bit)
    if
        not target:isPC() and
        bit.band(target:getBehavior(), xi.behavior.RAISABLE) == 0
    then
        return xi.msg.basic.MAGIC_CANNOT_BE_CAST
    end

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:isPC() then
        target:sendRaise(3)
    else
        -- NPC ally "raise" behavior (instant revive style)
        target:addHP(target:getMaxHP())
        target:addMP(target:getMaxMP())
        target:entityAnimationPacket(xi.animationString.SPECIAL_00)
    end

    spell:setMsg(xi.msg.basic.MAGIC_CASTS_ON)
    return 3
end

return spellObject
