-----------------------------------
-- ID: 4924
-- Scroll of Thundara
-- Teaches the black magic Thundara
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.THUNDARA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDARA)
end

return itemObject
