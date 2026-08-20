-----------------------------------
-- ID: 4513
-- Item: Amrita
-- Item Effect: Restores 500 HP and MP over 300 seconds.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user, item, action)
    local regenEffect     = target:getStatusEffect(xi.effect.REGEN)
    local refreshEffect   = target:getStatusEffect(xi.effect.REFRESH)
    local canApplyRegen   = not regenEffect or regenEffect:getTier() == 0
    local canApplyRefresh = not refreshEffect or refreshEffect:getTier() == 0

    if canApplyRegen then
        target:delStatusEffectSilent(xi.effect.REGEN) -- All Regen items overwrite freely, and their effect expires silently if overwritten.

        target:addStatusEffect(xi.effect.REGEN, { power = 5, duration = 300, origin = user, tick = 3 })
    end

    if canApplyRefresh then
        target:delStatusEffectSilent(xi.effect.REFRESH) -- All Refresh items overwrite freely, and their effect expires silently if overwritten.

        target:addStatusEffect(xi.effect.REFRESH, { power = 5, duration = 300, origin = user, tick = 3 })
    end

    if
        not canApplyRegen and
        not canApplyRefresh
    then
        action:messageID(target:getID(), xi.msg.basic.ITEM_NO_EFFECT) -- Displays no effect when both Regen and Refresh are protected by tiered spell effects.

        return 0
    end
end

return itemObject
