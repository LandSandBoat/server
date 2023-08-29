-----------------------------------
-- ID: 4734
-- Scroll of Protectra II
-- Teaches the white magic Protectra II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.PROTECTRA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PROTECTRA_II)
end

return itemObject
