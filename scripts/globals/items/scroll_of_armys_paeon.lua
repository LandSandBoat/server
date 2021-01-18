-----------------------------------
-- ID: 4986
-- Scroll of Armys Paeton
-- Teaches the song Armys Paeton
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(378)
end

item_object.onItemUse = function(target)
    target:addSpell(378)
end

return item_object
