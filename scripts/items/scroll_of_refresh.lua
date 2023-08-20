-----------------------------------
-- ID: 4717
-- Scroll of Refresh
-- Teaches the white magic Refresh
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.REFRESH)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.REFRESH)
end

return itemObject
