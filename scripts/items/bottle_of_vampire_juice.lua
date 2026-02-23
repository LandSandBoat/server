-----------------------------------
-- ID: 4512
-- Item: Vampire Juice
-- Item Effect: Restores 60 HP and MP over 90 seconds.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    local worked = false
    if not target:hasStatusEffect(xi.effect.REGEN) then
        target:addStatusEffect(xi.effect.REGEN, { power = 2, duration = 90, origin = user, tick = 3 })
        worked = true
    end

    if not target:hasStatusEffect(xi.effect.REFRESH) then
        target:addStatusEffect(xi.effect.REFRESH, { power = 2, duration = 90, origin = user, tick = 3 })
        worked = true
    end

    if not worked then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
