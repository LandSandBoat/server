-----------------------------------
-- Dagan
-- Description: Restores HP and MP. Amount restored varies with TP. Gambanteinn: Aftermath.
-- Acquired permanently by completing the appropriate Walk of Echoes Weapon Skill Trials.
-- Can also be used by equipping Gambanteinn (85), Gambanteinn (90), Canne de Combat +1 or Canne de Combat +2.
-- Skillchain Properties: N/A
-- Modifiers: Max HP / Max MP
-- Amount restored in HP/MP by TP
-- Does not deal damage.
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.EMPYREAN)

    local ftphp = xi.weaponskills.fTP(tp, { 0.22, 0.33, 0.513 }) -- DAT, but BG and FFO say 0.52 at 3000 TP
    local ftpmp = xi.weaponskills.fTP(tp, { 0.15, 0.225, 0.35 }) -- DAT, but BG and FFO say 0.22 at 2000 TP
    player:addHP(ftphp * player:getMaxHP())
    return 0, 0, false, ftpmp * player:getMaxMP()
end

return weaponskillObject
