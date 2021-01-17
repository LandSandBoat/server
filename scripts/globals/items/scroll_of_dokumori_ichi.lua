-----------------------------------------
-- ID: 4958
-- Scroll of Dokumori: Ichi
-- Teaches the ninjutsu Dokumori: Ichi
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(350)
end

item_object.onItemUse = function(target)
    target:addSpell(350)
end

return item_object
