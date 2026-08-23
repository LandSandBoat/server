-----------------------------------
-- Got It All
-- Restores the real-midnight wait before Tehf Kimasnahya's final event.
-- The July 8, 2014 version update abolished the JST midnight wait.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/43135-Jul-8-2014-(JST)-Version-Update
-- Source: https://wiki.ffo.jp/html/5374.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_got_it_all', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/ahtUrhgan/Got_It_All', function(quest)
        local whitegate = quest.sections[2][xi.zone.AHT_URHGAN_WHITEGATE]

        -- Restores the JST Midnight Wait
        whitegate.onEventFinish[527] = function(player, csid, option, npc)
            quest:setVar(player, 'Prog', 7)
            quest:setVar(player, 'Stage', JstMidnight())
            player:needToZone(true)
        end
    end)
end)
