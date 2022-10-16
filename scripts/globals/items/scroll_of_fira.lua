-----------------------------------
-- ID: 4916
-- Scroll of Fira
-- Teaches the black magic Fira
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FIRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRA)
end

return itemObject
