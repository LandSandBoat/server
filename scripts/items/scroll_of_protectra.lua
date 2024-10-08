-----------------------------------
-- ID: 4733
-- Scroll of Protectra
-- Teaches the white magic Protectra
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.PROTECTRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PROTECTRA)
end

return itemObject
