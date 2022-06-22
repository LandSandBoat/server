-----------------------------------
-- ID: 4924
-- Scroll of Thundara
-- Teaches the black magic Thundara
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.THUNDARA)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDARA)
end

return item_object
