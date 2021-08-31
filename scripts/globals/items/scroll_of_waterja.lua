-----------------------------------
-- ID: 4895
-- Scroll of Waterja
-- Teaches the Black magic Waterja
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(501)
end

item_object.onItemUse = function(target)
    target:addSpell(501)
end

return item_object
