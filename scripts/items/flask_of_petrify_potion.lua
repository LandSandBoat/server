-----------------------------------
-- ID: 4160
-- Item: Petrify Potion
-- Item Effect: This potion induces petrify.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.PETRIFICATION) then
        target:addStatusEffect(xi.effect.PETRIFICATION, { power = 1, duration = 180, origin = user, tick = 3 })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
