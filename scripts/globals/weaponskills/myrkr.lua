-----------------------------------
-- Myrkr
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskill_object = {}

weaponskill_object.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    -- Apply aftermath
    tpz.aftermath.addStatusEffect(player, tp, tpz.slot.MAIN, tpz.aftermath.type.EMPYREAN)

    local ftpmp = fTP(tp, 0.2, 0.4, 0.6)
    return 1, 0, false, ftpmp * player:getMaxMP()
end

return weaponskill_object
