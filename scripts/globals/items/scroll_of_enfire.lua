-----------------------------------
-- ID: 4708
-- Scroll of Enfire
-- Teaches the white magic Enfire
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ENFIRE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENFIRE)
end

return itemObject
