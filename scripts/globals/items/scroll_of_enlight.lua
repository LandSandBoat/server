-----------------------------------
-- ID: 4706
-- Scroll of Enlight
-- Teaches the white magic Enlight
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ENLIGHT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENLIGHT)
end

return itemObject
