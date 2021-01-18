-----------------------------------
--    Dagan     --
-- Description: Restores HP and MP. Amount restored varies with TP. Gambanteinn: Aftermath.
-- Acquired permanently by completing the appropriate Walk of Echoes Weapon Skill Trials.
-- Can also be used by equipping Gambanteinn (85), Gambanteinn (90), Canne de Combat +1 or Canne de Combat +2.
-- Skillchain Properties: N/A
-- Modifiers: Max HP / Max MP
-- Amount restored in HP/MP by TP
-- Does not deal damage.
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskill_object = {}

weaponskill_object.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    -- Apply aftermath
    tpz.aftermath.addStatusEffect(player, tp, tpz.slot.MAIN, tpz.aftermath.type.EMPYREAN)

    local ftphp = fTP(tp, 0.22, 0.33, 0.52)
    local ftpmp = fTP(tp, 0.15, 0.22, 0.35)
    player:addHP(ftphp * player:getMaxHP())
    return 0, 0, false, ftpmp * player:getMaxMP()
end

return weaponskill_object
