-----------------------------------
-- ID: 4513
-- Item: Amrita
-- Item Effect: Restores 500 HP and MP over 300 seconds.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    local worked = false
    if not target:hasStatusEffect(xi.effect.REGEN) then
        target:addStatusEffect(xi.effect.REGEN, { power = 5, duration = 300, origin = user, tick = 3 })
        worked = true
    end

    if not target:hasStatusEffect(xi.effect.REFRESH) then
        target:addStatusEffect(xi.effect.REFRESH, { power = 5, duration = 300, origin = user, tick = 3 })
        worked = true
    end

    if not worked then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
