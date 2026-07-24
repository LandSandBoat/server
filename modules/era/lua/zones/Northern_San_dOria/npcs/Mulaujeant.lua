-----------------------------------
-- Module to restore the era wait time on the 'Missionary Man' quest.
-- Statue creation completed at JP midnight. This was later reduced to a
-- 1 minute (Earth time) wait, observed on the September 9 2014 update.
-- Part of SE's ongoing removal of JP midnight waits; the July 8 2014
-- update (thread 43135) did the same for 16 other quests.
-----------------------------------
-- Sources:
--   BG-Wiki rev 2012-06-27 (JP midnight):
--     https://www.bg-wiki.com/index.php?title=Missionary_Man&oldid=228476
--   BG-Wiki rev 2014-09-09 ("wait is now one minute"):
--     https://www.bg-wiki.com/index.php?title=Missionary_Man&oldid=385002
--   July 8 2014 version update (precedent):
--     https://forum.square-enix.com/ffxi/threads/43135
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_quest_missionary_man'

if xi.module.isContentEnabled('SOA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.zones.Northern_San_dOria.npcs.Mulaujeant.onEventFinish', function(player, csid, option, npc)
    if csid == 698 then
        player:setCharVar('MissionaryManVar', 3)
        player:setCharVar('MissionaryMan_date', JstMidnight())
        player:delKeyItem(xi.ki.RAUTEINOTS_PARCEL)
        player:needToZone(true)
    elseif csid == 700 then
        player:setCharVar('MissionaryManVar', 4)
        player:setCharVar('MissionaryMan_date', 0)
        npcUtil.giveKeyItem(player, xi.ki.SUBLIME_STATUE_OF_THE_GODDESS)
    end
end)

return m
