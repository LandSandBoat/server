-----------------------------------
-- ID: 4966
-- Scroll of Myoshu: Ichi
-- Teaches the ninjutsu Myoshu: Ichi
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(507)
end

item_object.onItemUse = function(target)
    target:addSpell(507)
end

return item_object
