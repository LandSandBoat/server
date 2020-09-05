-----------------------------------------
-- ID: 4198
-- Item: Page from the Dragon Chronicles
-- Grants 500 - 1, 000 EXP
-- Does not grant Limit Points.
--
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local check = 56
    if (target:getMainLvl() >= 4) then
        check = 0
    end
    return check
end

function onItemUse(target)
    target:addExp(EXP_RATE * math.random(500, 1000))
end
