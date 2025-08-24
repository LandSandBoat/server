-----------------------------------
-- Update Zalsuhn to require scaling ws points based on nyzul climb (pre 2014)
-- Also update the required WS points for all Vigil weapons latent ability
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('unlocking_a_myth')

local weaponList =
{
    'brave_blade',
    'burning_fists',
    'dancing_dagger',
    'death_sickle',
    'double_axe',
    'elder_staff',
    'inferno_claws',
    'killer_bow',
    'mages_staff',
    'main_gauche',
    'quicksilver',
    'radiant_lance',
    'sasuke_katana',
    'scepter_staff',
    'sturdy_axe',
    'swordbreaker',
    'vorpal_sword',
    'werebuster',
    'wightslayer',
    'windslicer',
}

m:addOverride('xi.equipment.vigilWeaponRequiredWsPoints', function(player)
    local nyzulFloorProgress = player:getCharVar('NyzulFloorProgress')
    if nyzulFloorProgress == 100 then
        return 250
    elseif nyzulFloorProgress >= 80 then
        return 500 + 20 * (99 - nyzulFloorProgress)
    elseif nyzulFloorProgress >= 60 then
        return 1000 + 40 * (79 - nyzulFloorProgress)
    elseif nyzulFloorProgress >= 40 then
        return 2000 + 80 * (59 - nyzulFloorProgress)
    elseif nyzulFloorProgress >= 20 then
        return 4000 + 160 * (39 - nyzulFloorProgress)
    elseif nyzulFloorProgress > 0 then
        return 8000 + 320 * (19 - nyzulFloorProgress)
    else
        return 16000
    end
end)

for _, weaponName in ipairs(weaponList) do
    xi.module.ensureTable(fmt('xi.items.{}', weaponName))
    m:addOverride(fmt('xi.items.{}.onItemEquip', weaponName), function(target, item)
        item:setWeaponskillPointsNeeded(xi.equipment.vigilWeaponRequiredWsPoints(target))
    end)
end

return m
