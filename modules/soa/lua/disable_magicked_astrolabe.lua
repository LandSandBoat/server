-----------------------------------
-- Disable Magicked Astrolabe (Solo Eldieme Necropolis Access)
-- Source: https://forum.square-enix.com/ffxi/threads/40059
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('disable_magicked_astrolabe')

m:addOverride('xi.zones.Windurst_Waters.npcs.Churano-Shurano.onTrigger', function(player, npc)
    player:startEvent(280)
end)

m:addOverride('xi.zones.Windurst_Waters.npcs.Churano-Shurano.onEventUpdate', function(player, csid, option, npc)
end)

m:addOverride('xi.zones.Windurst_Waters.npcs.Churano-Shurano.onEventFinish', function(player, csid, option, npc)
end)

return m
