-----------------------------------
-- ID: 4919
-- Scroll of Blizzara II
-- Teaches the black magic Blizzara II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BLIZZARA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIZZARA_II)
end

return itemObject
