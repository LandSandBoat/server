-----------------------------------
-- ID: 6059
-- Item: Animus Augeo Schema
-- Teaches the white magic Animus Augeo
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ANIMUS_AUGEO)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ANIMUS_AUGEO)
end

return itemObject
