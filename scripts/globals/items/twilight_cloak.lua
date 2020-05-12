-----------------------------------------
-- ID: 11363
-- Equip: Twilight Cloak
-- Able to cast "Impact"
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)

local body = target:getEquipID(tpz.slot.BODY)

    if (body == 11363) then
        target:addSpell(503)
    else
        target:delSpell(503)
    end
end
