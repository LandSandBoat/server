-----------------------------------
-- ID: 5576
-- Item: Ayran
-- Item Effect: Restores 120 HP over 180 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:addStatusEffect(xi.effect.REGEN, { power = 2, duration = 180, origin = user, tick = 3 }) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
