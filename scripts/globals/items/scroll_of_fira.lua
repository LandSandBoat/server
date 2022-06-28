-----------------------------------
-- ID: 4916
-- Scroll of Fira
-- Teaches the black magic Fira
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FIRA)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRA)
end

return item_object
