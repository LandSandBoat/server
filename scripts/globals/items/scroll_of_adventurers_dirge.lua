-----------------------------------
-- ID: 5077
-- Scroll of Adventurer's Dirge
-- Teaches the song Adventurer's Dirge
-----------------------------------
require("scripts/globals/items")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(469)
end

itemObject.onItemUse = function(target)
    target:addSpell(469)
end

return itemObject
