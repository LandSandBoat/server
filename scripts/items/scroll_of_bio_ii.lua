-----------------------------------
-- ID: 4839
-- Scroll of Bio II
-- Teaches the black magic Bio II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BIO_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BIO_II)
end

return itemObject
