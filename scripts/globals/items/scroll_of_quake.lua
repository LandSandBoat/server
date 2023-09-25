-----------------------------------
-- ID: 4818
-- Scroll of Quake
-- Teaches the black magic Quake
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.QUAKE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.QUAKE)
end

return itemObject
