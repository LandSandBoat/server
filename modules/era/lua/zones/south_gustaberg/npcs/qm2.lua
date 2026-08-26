-----------------------------------
-- Smoke on the Mountain
-- Restores the one Vana'diel day cook for meat left on the South Gustaberg campfire.
-- The June 7, 2016 version update shortened the wait to one minute (Earth time).
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/50760-Jun.-7-2016-(JST)-Version-Update
-- Source: https://wiki.ffo.jp/html/8848.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_smoke_on_the_mountain', xi.pre(xi.expansion.ROV))

m:addOverride('xi.zones.South_Gustaberg.npcs.qm2.onTrade', function(player, npc, trade)
    local hadCook = player:getCharVar('SouthGustabergCampfire') ~= 0
    local result  = super(player, npc, trade)

    -- A fresh cook finishes one full Vana'diel day after the trade instead of at the next clock minute.
    if not hadCook and player:getCharVar('SouthGustabergCampfire') ~= 0 then
        player:setCharVar('SouthGustabergCampfire', GetSystemTime() + xi.vanaTime.DAY) -- Module change
    end

    return result
end)
