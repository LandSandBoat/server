-----------------------------------
-- ID: 4782
-- Scroll of Firaga
-- Teaches the black magic Firaga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FIRAGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRAGA)
end

return itemObject
