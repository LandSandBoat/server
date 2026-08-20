-----------------------------------
-- ID: 4422
-- Item: Orange Juice
-- Item Effect: Restores 30 MP over 1 minute and 30 seconds.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user, item, action)
    local refreshEffect = target:getStatusEffect(xi.effect.REFRESH)
    local legsEquipped  = target:getEquipID(xi.slot.LEGS)
    local refreshPower  = (legsEquipped == xi.item.DREAM_TROUSERS_P1 or legsEquipped == xi.item.DREAM_PANTS_P1) and 2 or 1

    if
        not refreshEffect or
        refreshEffect:getTier() == 0
    then
        target:delStatusEffectSilent(xi.effect.REFRESH) -- All Refresh items overwrite freely, and their effect expires silently if overwritten.

        target:addStatusEffect(xi.effect.REFRESH, { power = refreshPower, duration = 90, origin = user, tick = 3 })
    else
        action:messageID(target:getID(), xi.msg.basic.ITEM_NO_EFFECT) -- Displays no effect when attempting to overwrite tier 1, 2 or 3 Refresh.

        return 0
    end
end

return itemObject
