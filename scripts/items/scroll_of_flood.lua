-----------------------------------
-- ID: 4822
-- Scroll of Flood
-- Teaches the black magic Flood
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FLOOD)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FLOOD)
end

return itemObject
