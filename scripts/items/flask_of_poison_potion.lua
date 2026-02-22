-----------------------------------
-- ID: 4157
-- Item: Poison Potion
-- Item Effect: Poison 1HP / Removes 60 HP over 180 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.POISON) then
        target:addStatusEffect(xi.effect.POISON, { power = 1, duration = 180, origin = user, tick = 3 })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
