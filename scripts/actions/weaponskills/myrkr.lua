-----------------------------------
-- Myrkr
-- Staff weapon skill
-- Restores MP and removes up to three status ailments curable by -na spells or Erase. Amount of MP restored varies with TP.
-- Hvergelmir: Aftermath.
-- MP restored: percentage of max MP
-- 100%TP    200%TP    300%TP
-- 20%       40%       60%
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

local naAilments =
{
    xi.effect.POISON,
    xi.effect.PARALYSIS,
    xi.effect.BLINDNESS,
    xi.effect.SILENCE,
    xi.effect.PETRIFICATION,
    xi.effect.DISEASE,
    xi.effect.PLAGUE,
    xi.effect.CURSE_I,
}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.EMPYREAN)

    xi.itemUtils.removeMultipleEffects(player, naAilments, 3, 1)

    local ftpmp = xi.weaponskills.fTP(tp, { 0.2, 0.4, 0.6 })
    return 1, 0, false, ftpmp * player:getMaxMP()
end

return weaponskillObject
