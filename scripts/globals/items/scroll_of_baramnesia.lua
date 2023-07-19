-----------------------------------
-- ID: 4690
-- Scroll of Baramnesia
-- Teaches the white magic Baramnesia
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARAMNESIA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARAMNESIA)
end

return itemObject
