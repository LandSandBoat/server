-----------------------------------
-- ID: 5086
-- Scroll of Regen V
-- Teaches the white magic Regen V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.REGEN_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.REGEN_V)
end

return itemObject
