-----------------------------------
-- ID: 4301
-- Item: Persikos au Lait
-- Item Effect: Restores 800 HP over 600 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:addStatusEffect(xi.effect.REGEN, { power = 4, duration = 600, origin = user, tick = 3 }) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
