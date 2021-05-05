-----------------------------------
-- Spell: Sacrifice
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local count = 1

    local removables = {xi.effect.FLASH, xi.effect.BLINDNESS, xi.effect.PARALYSIS, xi.effect.POISON, xi.effect.CURSE_I, xi.effect.CURSE_II, xi.effect.DISEASE, xi.effect.PLAGUE}

    -- remove one effect and add it to me
    for i, effect in ipairs(removables) do

        if (target:hasStatusEffect(effect)) then
            spell:setMsg(xi.msg.basic.MAGIC_ABSORB_AILMENT)

            local statusEffect = target:getStatusEffect(effect)

            -- only add it to me if I don't have it
            if (caster:hasStatusEffect(effect) == false) then
                caster:addStatusEffect(effect, statusEffect:getPower(), statusEffect:getTickCount(), statusEffect:getDuration())
            end

            target:delStatusEffect(effect)
            return 1
        end
    end

    spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
    return 0
end

return spell_object
