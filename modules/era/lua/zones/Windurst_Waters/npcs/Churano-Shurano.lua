-----------------------------------
-- Disable Magicked Astrolabe (Solo Eldieme Necropolis Access)
-- Source: https://forum.square-enix.com/ffxi/threads/40059
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'disable_magicked_astrolabe'

if xi.module.isContentEnabled('SOA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.zones.Windurst_Waters.npcs.Churano-Shurano.onTrigger', function(player, npc)
    player:startEvent(280)
end)

m:addOverride('xi.zones.Windurst_Waters.npcs.Churano-Shurano.onEventUpdate', function(player, csid, option, npc)
end)

m:addOverride('xi.zones.Windurst_Waters.npcs.Churano-Shurano.onEventFinish', function(player, csid, option, npc)
end)

return m
