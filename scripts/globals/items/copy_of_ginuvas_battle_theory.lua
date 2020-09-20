-----------------------------------------
-- ID: 4198
-- Item: Copy of "Ginuva's Battle Theory"
-- Grants 50 - 200 EXP
-- Does not grant Limit Points.
--
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local check = 56
    if (target:getMainLvl() >= 65) then
        check = 0
    end
    return check
end

function onItemUse(target)
    target:addExp(EXP_RATE * math.random(50, 200))
end
