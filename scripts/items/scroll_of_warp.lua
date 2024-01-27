-----------------------------------
-- ID: 4869
-- Scroll of Warp
-- Teaches the black magic Warp
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WARP)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WARP)
end

return itemObject
