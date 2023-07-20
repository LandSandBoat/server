-----------------------------------
-- ID: 5085
-- Scroll of Regen IV
-- Teaches the white magic Regen IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.REGEN_IV)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.REGEN_IV)
end

return itemObject
