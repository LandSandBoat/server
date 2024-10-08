-----------------------------------
-- ID: 4918
-- Scroll of Blizzara
-- Teaches the black magic Blizzara
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BLIZZARA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIZZARA)
end

return itemObject
