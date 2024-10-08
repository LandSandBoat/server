-----------------------------------
-- ID: 4838
-- Scroll of Bio
-- Teaches the black magic Bio
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BIO)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BIO)
end

return itemObject
