-----------------------------------
-- ID: 5077
-- Scroll of Adventurer's Dirge
-- Teaches the song Adventurer's Dirge
-----------------------------------
require("scripts/globals/items")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(469)
end

item_object.onItemUse = function(target)
    target:addSpell(469)
end

return item_object
