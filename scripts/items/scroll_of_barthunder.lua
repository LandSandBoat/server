-----------------------------------
-- ID: 4672
-- Scroll of Barthunder
-- Teaches the white magic Barthunder
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BARTHUNDER)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARTHUNDER)
end

return itemObject
