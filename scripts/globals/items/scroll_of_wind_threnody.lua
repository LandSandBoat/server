-----------------------------------------
-- ID: 5064
-- Scroll of Wind Threnody
-- Teaches the song Wind Threnody
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(456)
end

item_object.onItemUse = function(target)
    target:addSpell(456)
end

return item_object
