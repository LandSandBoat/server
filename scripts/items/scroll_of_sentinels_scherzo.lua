-----------------------------------
-- ID: 5078
-- Scroll of Sentinel's Scherzo
-- Teaches the song Sentinel's Scherzo
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.SENTINELS_SCHERZO)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SENTINELS_SCHERZO)
end

return itemObject
