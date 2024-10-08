-----------------------------------
-- ID: 4924
-- Scroll of Thundara
-- Teaches the black magic Thundara
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.THUNDARA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDARA)
end

return itemObject
