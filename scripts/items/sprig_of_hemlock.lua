-----------------------------------
-- ID: 5985
-- Item: Sprig of Hemlock
-- Food Effect: 5 Min, All Races
-- Paralysis
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.PARALYSIS) then
        target:addStatusEffect(xi.effect.PARALYSIS, { power = 20, duration = 600, origin = user })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
