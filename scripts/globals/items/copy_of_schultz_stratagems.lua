-----------------------------------------
-- ID: 4249
-- Item: Copy of Schultz Stratage
-- Grants 150 - 500 EXP
-- Does not grant Limit Points.
--
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local check = 56
    if (target:getMainLvl() >= 65) then
        check = 0
    end
    return check
end

item_object.onItemUse = function(target)
    target:addExp(EXP_RATE * math.random(150, 500))
end

return item_object
