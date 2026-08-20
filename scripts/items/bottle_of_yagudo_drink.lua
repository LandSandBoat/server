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

itemObject.onItemUse = function(target, user)
    if not target:addStatusEffect(xi.effect.REFRESH, { power = 2, duration = 180, origin = user, tick = 3 }) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
