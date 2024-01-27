-----------------------------------
-- ID: 4701
-- Scroll of Cura
-- Teaches the white magic Cura
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.CURA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CURA)
end

return itemObject
