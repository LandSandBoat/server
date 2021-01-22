-----------------------------------
-- ID: 4198
-- Item: Page from the Dragon Chronicles
-- Grants 500 - 1, 000 EXP
-- Does not grant Limit Points.
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local check = 56
    if (target:getMainLvl() >= 4) then
        check = 0
    end
    return check
end

item_object.onItemUse = function(target)
    target:addExp(EXP_RATE * math.random(500, 1000))
end

return item_object
