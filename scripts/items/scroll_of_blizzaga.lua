-----------------------------------
-- ID: 4787
-- Scroll of Blizzaga
-- Teaches the black magic Blizzaga
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BLIZZAGA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIZZAGA)
end

return itemObject
