-----------------------------------
-- ID: 4423
-- Item: Apple Juice
-- Item Effect: Restores 45 MP over 135 seconds.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:addStatusEffect(xi.effect.REFRESH, { power = 1, duration = 135, origin = user, tick = 3 }) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
