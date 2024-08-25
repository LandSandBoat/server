-----------------------------------
-- ID: 4641
-- Scroll of Diaga
-- Teaches the white magic Diaga
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.DIAGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DIAGA)
end

return itemObject
