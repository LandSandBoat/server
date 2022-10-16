-----------------------------------
-- ID: 4925
-- Scroll of Thundara II
-- Teaches the black magic Thundara II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.THUNDARA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDARA_II)
end

return itemObject
