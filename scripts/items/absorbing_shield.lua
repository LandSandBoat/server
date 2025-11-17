-----------------------------------
-- ID: 12408
-- Item: Absorbing Shield
-- Item Effect: Transfers one random effect from the target to its user.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user, item, action)
    local numEffectsTransferred = 0
    local availableEffects = {}

    -- Get all effects from target and filter by flags
    local allEffects = target:getStatusEffects()
    for _, effect in pairs(allEffects) do
        local effectId = effect:getEffectType()
        local flags = effect:getEffectFlags()

        -- Check if effect has DISPELABLE, WALTZABLE, or ERASABLE flags
        if bit.band(flags, bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.WALTZABLE, xi.effectFlag.ERASABLE)) ~= 0 then
            table.insert(availableEffects, effectId)
        end
    end

    -- Add petrification if present
    if target:hasStatusEffect(xi.effect.PETRIFICATION) then
        table.insert(availableEffects, xi.effect.PETRIFICATION)
    end

    -- Transfer only 1 random effect
    if #availableEffects > 0 then
        -- Shuffle and pick the first one
        availableEffects = utils.shuffle(availableEffects)
        local effectId = availableEffects[1]
        local effect = target:getStatusEffect(effectId)

        if effect and target:delStatusEffect(effectId) then
            user:addStatusEffect(
                effectId,
                effect:getPower(),
                effect:getTick(),
                math.ceil(effect:getTimeRemaining() / 1000), -- Gets the remaining time and converts milliseconds to seconds
                effect:getSubType(),
                effect:getSubPower(),
                effect:getTier()
            )
            numEffectsTransferred = 1
        end
    end

    if numEffectsTransferred > 0 then
        return 0
    end
end

return itemObject
