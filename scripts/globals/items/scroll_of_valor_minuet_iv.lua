-----------------------------------
-- ID: 5005
-- Scroll of Valor Minuet IV
-- Teaches the song Valor Minuet IV
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(397)
end

item_object.onItemUse = function(target)
    target:addSpell(397)
end

return item_object
