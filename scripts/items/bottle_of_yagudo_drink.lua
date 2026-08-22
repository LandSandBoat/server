-----------------------------------
-- ID: 4558
-- Item: Yagudo Drink
-- Item Effect: Restores 120 MP over 3 minutes
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

        target:addStatusEffect(xi.effect.REFRESH, { power = 2, duration = 180, origin = user, tick = 3 })
    else
        action:messageID(target:getID(), xi.msg.basic.ITEM_NO_EFFECT) -- Displays no effect when attempting to overwrite tier 1, 2 or 3 Refresh.

        return 0
    end
end

return itemObject
