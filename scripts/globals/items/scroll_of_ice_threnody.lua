-----------------------------------
-- ID: 5063
-- Scroll of Ice Threnody
-- Teaches the song Ice Threnody
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(455)
end

item_object.onItemUse = function(target)
    target:addSpell(455)
end

return item_object
