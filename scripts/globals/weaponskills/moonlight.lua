-----------------------------------
-- Moonlight
-----------------------------------
require("scripts/globals/status")
require("scripts/settings/main")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskill_object = {}

weaponskill_object.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local lvl = player:getSkillLevel(11) -- get club skill
    local damage = (lvl/9) - 1
    local damagemod = damage * ((50+(tp*0.05))/100)
    damagemod = damagemod * xi.settings.WEAPON_SKILL_POWER
    return 1, 0, false, damagemod
end

return weaponskill_object
