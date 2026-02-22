-----------------------------------
-- ID: 5933
-- Item: Flask of Dragon Fruit au Lait
-- Item Effect: Restores 600 HP over 300 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.REGEN) then
        target:addStatusEffect(xi.effect.REGEN, { power = 6, duration = 300, origin = user, tick = 3 })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
