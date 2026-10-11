-----------------------------------
-- Module: Avatar Adjustments
-- Description: Various overrides for Summoner/Avatar related changes.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_avatar_adjustments')

-- Revert to original avatar base damage ((Level + 2) / 2)
-- https://wiki.ffo.jp/html/31916.html
-- https://docs.google.com/spreadsheets/d/1YBoveP-weMdidrirY-vPDzHyxbEI2ryECINlfCnFkLI/edit?pli=1&gid=562618210#gid=562618210
m:addOverrideByEra('xi.pets.avatar.calculateAvatarWeaponDamage', {
    [xi.expansion.SOA] = function(pet)
        pet:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 50)
    end,
})
