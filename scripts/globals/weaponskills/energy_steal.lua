-----------------------------------
-- Energy Steal
-----------------------------------
require("scripts/globals/status")
require("scripts/settings/main")
require("scripts/globals/weaponskills")
require("scripts/globals/msg")
-----------------------------------
local weaponskill_object = {}

weaponskill_object.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    -- TODO: Should not wake the mob involved. Not tested on sleeping mob

    local damage = 40 -- Base mp absorbtion from http://wiki.ffo.jp/html/686.html saying it would do between 40 and 80

    -- params.ftp100 = 1 params.ftp200 = 1.5 params.ftp300 = 2  from https://ffxiclopedia.fandom.com/wiki/Energy_Steal
    -- params.mnd_wsc = 1

    local damagemod = damage * ((tp - 1000) / 2000 + 1) -- Simplified formula for getting difference in tp return from 1000 tp to 3000 tp

    if xi.settings.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        local attMind = player:getStat(xi.mod.MND)
        damagemod = damagemod + attMind * 1
    end

    damagemod = damagemod * xi.settings.WEAPON_SKILL_POWER
    local mpReturn = target:addMP(-damagemod)
    player:addMP(mpReturn) -- this isnt the right way but the only way I could figure out
    -- to do make undead undrainable

    return 1, 0, false, 0
end

return weaponskill_object
