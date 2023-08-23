-----------------------------------
-- ID: 5105
-- Scroll of Flurry II
-- Teaches the white magic Flurry II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FLURRY_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FLURRY_II)
end

return itemObject
