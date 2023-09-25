-----------------------------------
-- ID: 4692
-- Scroll of Haste II
-- Teaches the white magic Haste II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.HASTE_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HASTE_II)
end

return itemObject
