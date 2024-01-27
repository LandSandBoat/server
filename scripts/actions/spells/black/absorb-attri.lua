-----------------------------------
-- Spell: Absorb-Attri
-- Steals an enemy's beneficial status effects.
-- NOTE: Nether Void allows for two beneficial status effects to be absorbed.
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local count = 0
    local effectFirst = caster:stealStatusEffect(target, xi.effectFlag.DISPELLABLE)

    if effectFirst ~= 0 then
        count = 1

        if caster:hasStatusEffect(xi.effect.NETHER_VOID) then
            local effectSecond = caster:stealStatusEffect(target, xi.effectFlag.DISPELLABLE)
            if effectSecond ~= 0 then
                count = count + 1
            end
        end

        spell:setMsg(xi.msg.basic.MAGIC_STEAL)

        return count
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
    end

    return count
end

return spellObject
