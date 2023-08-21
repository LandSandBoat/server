-----------------------------------
-- ID: 4250
-- Crackler
-- Bursts of light appear in front of the user with a crackling sound, with the word "Congratulations!"
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
