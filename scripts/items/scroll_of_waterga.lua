-----------------------------------
-- ID: 4807
-- Scroll of Waterga
-- Teaches the black magic Waterga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WATERGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATERGA)
end

return itemObject
