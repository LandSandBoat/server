-----------------------------------
-- ID: 4703
-- Scroll of Esuna
-- Teaches the white magic Esuna
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ESUNA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ESUNA)
end

return itemObject
