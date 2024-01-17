-----------------------------------
-- Spell: Sacrifice
-----------------------------------

local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local removables = { xi.effect.FLASH, xi.effect.BLINDNESS, xi.effect.PARALYSIS, xi.effect.POISON, xi.effect.CURSE_I, xi.effect.CURSE_II, xi.effect.DISEASE, xi.effect.PLAGUE }

    -- Maximum number of effects to transfer
    local maxTransferCount = caster:hasStatusEffect(xi.effect.AFFLATUS_SOLACE) and 7 or 1

    -- Use the helper function to transfer status effects
    local transferCount = 0  -- Initialize transferCount

    -- Loop over the original effects
    for _, effect in ipairs(removables) do
        if transferCount < maxTransferCount then
            if target:hasStatusEffect(effect) then
                local statusEffect = target:getStatusEffect(effect)

                -- only add it to me if I don't have it
                if not caster:hasStatusEffect(effect) then
                    caster:addStatusEffect(effect, statusEffect:getPower(), statusEffect:getTickCount(), statusEffect:getDuration())
                    transferCount = transferCount + 1
                end

                target:delStatusEffect(effect)
            end
        else
            break  -- Break the loop if the maximum number of effects are transferred
        end
    end

    -- Check if the maximum transfer count is not reached
    while transferCount < maxTransferCount do
        local erasableEffect = caster:stealStatusEffect(target, xi.effectFlag.ERASABLE)
        if erasableEffect ~= 0 then
            transferCount = transferCount + 1
        else
            break  -- Break the loop if no more erasable effects are available
        end
    end

    if transferCount > 0 then
        spell:setMsg(xi.msg.basic.MAGIC_ABSORB_AILMENT)
        return transferCount
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
        return 0
    end
end

return spellObject
