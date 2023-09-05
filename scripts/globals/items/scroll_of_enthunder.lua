-----------------------------------
-- ID: 4712
-- Scroll of Enthunder
-- Teaches the white magic Enthunder
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ENTHUNDER)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENTHUNDER)
end

return itemObject
