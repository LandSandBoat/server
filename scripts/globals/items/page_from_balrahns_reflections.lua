-----------------------------------------
-- ID: 5415
-- Item:  Hero's Reflections
-- Grants 200 - 500 EXP
-- Does not grant Limit Points.
--
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local check = 56
    if (target:getMainLvl() >= 60) then
        check = 0
    end
    return check
end

function onItemUse(target)
    target:addExp(EXP_RATE * math.random(200, 500))
end
