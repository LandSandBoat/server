-----------------------------------
-- ID: 4623
-- Scroll of Paralyna
-- Teaches the white magic Paralyna
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.PARALYNA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PARALYNA)
end

return itemObject
