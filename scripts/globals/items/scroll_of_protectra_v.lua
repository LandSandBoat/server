-----------------------------------
-- ID: 4737
-- Scroll of Protectra V
-- Teaches the white magic Protectra V
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(129)
end

item_object.onItemUse = function(target)
    target:addSpell(129)
end

return item_object
