-----------------------------------
-- ID: 4720
-- Scroll of Flash
-- Teaches the white magic Flash
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.FLASH)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FLASH)
end

return itemObject
