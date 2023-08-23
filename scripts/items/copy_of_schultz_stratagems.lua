-----------------------------------
-- ID: 4249
-- Item: Copy of Schultz Stratage
-- Grants 150 - 500 EXP
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
    target:addExp(xi.settings.main.EXP_RATE * math.random(150, 500))
end

return itemObject
