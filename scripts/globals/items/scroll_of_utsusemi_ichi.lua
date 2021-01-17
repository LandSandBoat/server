-----------------------------------------
-- ID: 4946
-- Scroll of Utsusemi: Ichi
-- Teaches the ninjutsu Utsusemi: Ichi
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(338)
end

item_object.onItemUse = function(target)
    target:addSpell(338)
end

return item_object
