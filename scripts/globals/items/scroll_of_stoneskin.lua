-----------------------------------
-- ID: 4662
-- Scroll of Stoneskin
-- Teaches the white magic Stoneskin
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.STONESKIN)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONESKIN)
end

return itemObject
