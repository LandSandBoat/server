-----------------------------------
-- Energy Steal
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
require("scripts/globals/msg")
-----------------------------------
local weaponskill_object = {}

weaponskill_object.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    -- TODO: Should not wake the mob involved. Not tested on sleeping mob. Need to add Darkness element and resistance. More testing needed to understand retail behavior.

    --[[
    local damage = 40 -- Base mp absorbtion from http://wiki.ffo.jp/html/686.html saying it would do between 40 and 80 this is before adoulin era

    -- params.ftp100 = 1 params.ftp200 = 1.5 params.ftp300 = 2  from https://ffxiclopedia.fandom.com/wiki/Energy_Steal
    -- params.mnd_wsc = 1

    local damagemod = damage * ((tp - 1000) / 2000 + 1) -- Simplified formula for getting difference in tp return from 1000 tp to 3000 tp

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        damagemod = damagemod + player:getStat(xi.mod.MND)
    end

    damagemod = damagemod * xi.settings.main.WEAPON_SKILL_POWER

    if not target:isUndead() then
        player:addMP(target:addMP(-damagemod))
    end

    if not target:isUndead() then
        player:addMP(target:addMP(-damagemod))
    end
    --]]
    return 1, 0, false, 0
end

return weaponskill_object
