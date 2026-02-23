-----------------------------------
-- ID: 4166
-- Deodorizer
-- When applied, this powerful deodorant neutralizes even the strongest of odors!!.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if  not target:hasStatusEffect(xi.effect.DEODORIZE) then
        target:addStatusEffect(xi.effect.DEODORIZE, { power = 1, duration = 600, origin = user, tick = 10 })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
