-----------------------------------
--  ID: 16003
--  Reraise Earring
--  This earring functions in the same way as the spell Reraise.
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local duration = 2100
    target:delStatusEffect(tpz.effect.RERAISE)
    target:addStatusEffect(tpz.effect.RERAISE, 1, 0, duration)
end

return item_object
