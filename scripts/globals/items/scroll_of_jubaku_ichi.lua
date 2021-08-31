-----------------------------------
-- ID: 4949
-- Scroll of Jubaku: Ichi
-- Teaches the ninjutsu Jubaku: Ichi
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(341)
end

item_object.onItemUse = function(target)
    target:addSpell(341)
end

return item_object
