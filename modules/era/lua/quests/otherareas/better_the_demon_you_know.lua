-----------------------------------
-- Better the Demon You Know
-- Restores the JST midnight wait before Koblakiq finishes reading the demon pen.
-- The July 8, 2014 version update shortened the wait to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/43135-Jul-8-2014-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_better_the_demon_you_know', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/otherAreas/Better_The_Demon_You_Know', function(quest)
        local oldton  = quest.sections[2][xi.zone.OLDTON_MOVALPOLOS]
        local basePen = oldton.onEventFinish[22]

        -- Koblakiq works on the pen overnight. He sends the player on at JST midnight.
        oldton.onEventFinish[22] = function(player, csid, option, npc)
            basePen(player, csid, option, npc)
            quest:setVar(player, 'Wait', JstMidnight()) -- Module change
        end
    end)
end)
