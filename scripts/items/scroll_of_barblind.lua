-----------------------------------
-- ID: 4683
-- Scroll of Barblind
-- Teaches the white magic Barblind
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BARBLIND)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARBLIND)
end

return itemObject
