-----------------------------------
-- ID: 4646
-- Scroll of Banishga
-- Teaches the white magic Banishga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BANISHGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BANISHGA)
end

return itemObject
