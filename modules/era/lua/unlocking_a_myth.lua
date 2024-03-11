-----------------------------------
-- Update Zalsuhn to require scaling ws points based on nyzul climb (pre 2014)
-- Also update the required WS points for all Vigil weapons latent ability
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('unlocking_a_myth')

m:addOverride('xi.equipment.baseNyzulWeaponRequiredWsPoints', function(player)
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

return m
