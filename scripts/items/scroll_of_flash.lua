-----------------------------------
-- ID: 4720
-- Scroll of Flash
-- Teaches the white magic Flash
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FLASH)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FLASH)
end

return itemObject
