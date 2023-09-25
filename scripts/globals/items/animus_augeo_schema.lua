-----------------------------------
-- ID: 6059
-- Item: Animus Augeo Schema
-- Teaches the white magic Animus Augeo
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ANIMUS_AUGEO)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ANIMUS_AUGEO)
end

return itemObject
