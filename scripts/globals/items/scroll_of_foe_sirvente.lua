-----------------------------------
-- ID: 5076
-- Scroll of Foe Sirvente
-- Teaches the song Foe Sirvente
-----------------------------------
require("scripts/globals/items")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(468)
end

item_object.onItemUse = function(target)
    target:addSpell(468)
end

return item_object
