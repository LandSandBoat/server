-----------------------------------
-- ID: 4893
-- Scroll of Stoneja
-- Teaches the black magic Stoneja
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.STONEJA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONEJA)
end

return itemObject
