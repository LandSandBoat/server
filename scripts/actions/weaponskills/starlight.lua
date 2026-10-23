-----------------------------------
-- Starlight
-- Club weapon skill
-- Skill level: 100
-- Restores MP. Amount restored varies with TP.
-- MP restored: floor(club skill * 0.11) * multiplier
-- 100%TP    200%TP    300%TP
-- 2.00      3.00      4.00
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local lvl = player:getSkillLevel(xi.skill.CLUB)
    local mp  = (lvl - 10) / 9 * xi.weaponskills.fTP(tp, { 1.0, 2.0, 3.0 })

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        mp = math.floor(lvl * 0.11) * xi.weaponskills.fTP(tp, { 2.0, 3.0, 4.0 })
    end

    return 1, 0, false, math.floor(mp * xi.settings.main.WEAPON_SKILL_POWER)
end

return weaponskillObject
