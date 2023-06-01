-----------------------------------
-- ID: 4198
-- Item: Copy of "Ginuva's Battle Theory"
-- Grants 50 - 200 EXP
-- Does not grant Limit Points.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local check = 56
    if target:getMainLvl() >= 65 then
        check = 0
    end

    return check
end

itemObject.onItemUse = function(target)
    target:addExp(xi.settings.main.EXP_RATE * math.random(50, 200))
end

return itemObject
