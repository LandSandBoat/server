-----------------------------------
-- ID: 5769
-- Popper
-- Bursts of light appear in front of the user with a crackling sound, with the word "Congratulations!"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
