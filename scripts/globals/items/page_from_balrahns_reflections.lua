-----------------------------------
-- ID: 5415
-- Item:  Hero's Reflections
-- Grants 200 - 500 EXP
-- Does not grant Limit Points.
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local check = 56
    if (target:getMainLvl() >= 60) then
        check = 0
    end
    return check
end

item_object.onItemUse = function(target)
    target:addExp(xi.settings.EXP_RATE * math.random(200, 500))
end

return item_object
