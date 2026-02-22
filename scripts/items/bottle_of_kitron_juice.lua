-----------------------------------
-- ID: 5932
-- Item: Bottle of Kitron Juice
-- Item Effect: Restores 180 MP over 180 seconds.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.REFRESH) then
        target:addStatusEffect(xi.effect.REFRESH, { power = 3, duration = 180, origin = user, tick = 3 })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
