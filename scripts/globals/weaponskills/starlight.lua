-----------------------------------
-- Starlight
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskill_object = {}

weaponskill_object.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local lvl = player:getSkillLevel(11) -- get club skill
    local damage = (lvl-10)/9
    local damagemod = damage * (tp/1000)
    damagemod = damagemod * WEAPON_SKILL_POWER
    return 1, 0, false, damagemod
end

return weaponskill_object
