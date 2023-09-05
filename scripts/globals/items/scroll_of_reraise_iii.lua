-----------------------------------
-- ID: 4750
-- Scroll of Reraise III
-- Teaches the white magic Reraise III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.RERAISE_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.RERAISE_III)
end

return itemObject
