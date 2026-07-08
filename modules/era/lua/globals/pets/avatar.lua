-----------------------------------
-- Module: Avatar damage (Seekers of Adoulin era)
-- Desc: Revert to original avatar base damage ((Level + 2) / 2)
-- See: https://wiki.ffo.jp/html/31916.html
--      https://docs.google.com/spreadsheets/d/1YBoveP-weMdidrirY-vPDzHyxbEI2ryECINlfCnFkLI/edit?pli=1&gid=562618210#gid=562618210
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'soa_avatar_base_damage'

if xi.module.isContentEnabled('SOA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.pets.avatar.calculateAvatarWeaponDamage', function(pet)
    local weaponDamage = (pet:getMainLvl() + 2) / 2

    pet:setDamage(weaponDamage, xi.slot.MAIN)
    pet:setDamage(weaponDamage, xi.slot.RANGED)
end)

return m
