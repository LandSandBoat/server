-----------------------------------
-- ID: 4684
-- Scroll of Barsilence
-- Teaches the white magic Barsilence
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARSILENCE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARSILENCE)
end

return itemObject
