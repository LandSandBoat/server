-----------------------------------
-- ID: 4651
-- Scroll of Protect
-- Teaches the white magic Protect
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.PROTECT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PROTECT)
end

return itemObject
