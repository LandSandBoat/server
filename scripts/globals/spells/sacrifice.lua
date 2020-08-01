-----------------------------------------
-- Spell: Sacrifice
--
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local count = 1

    local removables = {tpz.effect.FLASH, tpz.effect.BLINDNESS, tpz.effect.PARALYSIS, tpz.effect.POISON, tpz.effect.CURSE_I, tpz.effect.CURSE_II, tpz.effect.DISEASE, tpz.effect.PLAGUE}

    -- remove one effect and add it to me
    for i, effect in ipairs(removables) do

        if (target:hasStatusEffect(effect)) then
            spell:setMsg(tpz.msg.basic.MAGIC_ABSORB_AILMENT)

            local statusEffect = target:getStatusEffect(effect)

            -- only add it to me if I don't have it
            if (caster:hasStatusEffect(effect) == false) then
                caster:addStatusEffect(effect, statusEffect:getPower(), statusEffect:getTickCount(), statusEffect:getDuration())
            end

            target:delStatusEffect(effect)
            return 1
        end
    end

    spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
    return 0
end
