-----------------------------------
-- ID: 5703
-- Item: Uleguerand Milk
-- Item Effect: Restores 80 HP over 120 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.REGEN) then
        target:addStatusEffect(xi.effect.REGEN, { power = 2, duration = 120, origin = user, tick = 3 })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
