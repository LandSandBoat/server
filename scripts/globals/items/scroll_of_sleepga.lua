-----------------------------------
-- ID: 4881
-- Scroll of Sleepga
-- Teaches the black magic Sleepga
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(273)
end

item_object.onItemUse = function(target)
    target:delSpell(363)
    target:addSpell(273)
end

return item_object
