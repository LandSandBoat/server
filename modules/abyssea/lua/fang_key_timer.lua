-----------------------------------
-- Lamian Fang Key Timer Module
-- Reverts timer to conquest tally instead of once per vanadiel day.
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('lamian_fang_key_tally_timer')

m:addOverride('xi.zones.Caedarva_Mire.npcs.qm8.onTrigger', function(player, npc)
    local ID = zones[xi.zone.CAEDARVA_MIRE]

    if player:getCharVar('[TIMER]Lamian_Fang_Key') == 0 then
        if npcUtil.giveItem(player, xi.item.LAMIAN_FANG_KEY) then
            player:setCharVar('[TIMER]Lamian_Fang_Key', 1, NextConquestTally()) -- Can obtain key once per conquest tally
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end)

return m
