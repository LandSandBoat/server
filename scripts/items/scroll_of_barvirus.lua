-----------------------------------
-- ID: 4686
-- Scroll of Barvirus
-- Teaches the white magic Barvirus
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BARVIRUS)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARVIRUS)
end

return itemObject
