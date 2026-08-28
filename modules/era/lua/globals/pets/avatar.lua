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
        local weaponDamage = (pet:getMainLvl() + 2) / 2

        pet:setDamage(weaponDamage, xi.slot.MAIN)
        pet:setDamage(weaponDamage, xi.slot.RANGED)
    end,
})

-- Reverts perpetuation cost which is calculated on pet spawn and set with a AVATAR_PERPETUATION mod on the player.
-- https://forum.square-enix.com/ffxi/threads/22099-March-27-2012-%28JST%29-Version-Update
m:addOverrideByEra('xi.pets.avatar.onMobSpawn', {
    [xi.expansion.ABYSSEA] = function(pet)
        super(pet)

        local master = pet:getMaster()

        if master and master:isPC() then
            xi.job_utils.summoner.applySpiritPerpetuationCost(master)
        end
    end,
})
