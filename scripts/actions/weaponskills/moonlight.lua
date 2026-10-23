-----------------------------------
-- Moonlight
-- Club weapon skill
-- Skill level: 125
-- Restores MP for party members in range. Amount varies with TP.
-- MP restored: floor(club skill * 0.11) * multiplier
-- 100%TP    200%TP    300%TP
-- 2.25      3.50      4.80
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local lvl = player:getSkillLevel(xi.skill.CLUB)
    local mp  = ((lvl - 100) / 9 + 10) * xi.weaponskills.fTP(tp, { 1.0, 1.5, 2.0 })

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        mp = math.floor(lvl * 0.11) * xi.weaponskills.fTP(tp, { 2.25, 3.5, 4.8 }) -- DAT, but BG and FFO say 4.75 at 3000 TP
    end

    return 1, 0, false, math.floor(mp * xi.settings.main.WEAPON_SKILL_POWER)
end

return weaponskillObject
