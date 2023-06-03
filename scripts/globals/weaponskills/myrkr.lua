-----------------------------------
-- Myrkr
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.EMPYREAN)

    local ftpmp = fTP(tp, 0.2, 0.4, 0.6)
    return 1, 0, false, ftpmp * player:getMaxMP()
end

return weaponskillObject
