-----------------------------------
-- ID: 4744
-- Scroll of Invisible
-- Teaches the white magic Invisible
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INVISIBLE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INVISIBLE)
end

return itemObject
