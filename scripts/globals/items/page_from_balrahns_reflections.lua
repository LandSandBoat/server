-----------------------------------
-- ID: 5415
-- Item:  Hero's Reflections
-- Grants 200 - 500 EXP
-- Does not grant Limit Points.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local check = 56
    if target:getMainLvl() >= 60 then
        check = 0
    end

    return check
end

itemObject.onItemUse = function(target)
    target:addExp(xi.settings.main.EXP_RATE * math.random(200, 500))
end

return itemObject
