-----------------------------------
-- ID: 5065
-- Scroll of Earth Threnody
-- Teaches the song Earth Threnody
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(457)
end

item_object.onItemUse = function(target)
    target:addSpell(457)
end

return item_object
