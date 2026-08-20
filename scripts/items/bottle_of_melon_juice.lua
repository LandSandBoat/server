-----------------------------------
-- ID: 4424
-- Item: Melon Juice
-- Item Effect: Restores 90 MP over 135 seconds.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user, item, action)
    local refreshEffect = target:getStatusEffect(xi.effect.REFRESH)

    if
        not refreshEffect or
        refreshEffect:getTier() == 0
    then
        target:delStatusEffectSilent(xi.effect.REFRESH) -- All Refresh items overwrite freely, and their effect expires silently if overwritten.

        target:addStatusEffect(xi.effect.REFRESH, { power = 2, duration = 135, origin = user, tick = 3 })
    else
        action:messageID(target:getID(), xi.msg.basic.ITEM_NO_EFFECT) -- Displays no effect when attempting to overwrite tier 1, 2 or 3 Refresh.

        return 0
    end
end

return itemObject
