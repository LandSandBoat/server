-----------------------------------
-- ID: 4740
-- Scroll of Shellra III
-- Teaches the white magic Shellra III
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.SHELLRA_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SHELLRA_III)
end

return itemObject
