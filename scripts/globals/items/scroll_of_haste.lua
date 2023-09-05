-----------------------------------
-- ID: 4665
-- Scroll of Haste
-- Teaches the white magic Haste
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.HASTE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HASTE)
end

return itemObject
