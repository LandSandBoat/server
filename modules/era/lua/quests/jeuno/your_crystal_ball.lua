-----------------------------------
-- Your Crystal Ball
-- Restores the JST midnight wait while the ahriman lens soaks in the Maze of Shakhrami.
-- The June 17, 2014 version update shortened the wait to one minute.
-- The update notes give no values; the JST midnight condition comes from the Japanese wiki.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/42614-Jun-17-2014-(JST)-Version-Update
-- Source: https://wiki.ffo.jp/html/5214.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_your_crystal_ball', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/jeuno/Your_Crystal_Ball', function(quest)
        local maze      = quest.sections[2][xi.zone.MAZE_OF_SHAKHRAMI]
        local baseTrade = maze['Rockwell'].onTrade

        -- The lens soaks overnight. Rockwell hands the sphere over at JST midnight.
        maze['Rockwell'].onTrade = function(player, npc, trade)
            local previousWait = quest:getVar(player, 'Wait')
            local result       = baseTrade(player, npc, trade)

            if quest:getVar(player, 'Wait') ~= previousWait then
                quest:setVar(player, 'Wait', JstMidnight()) -- Module change
            end

            return result
        end
    end)
end)
