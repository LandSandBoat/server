-----------------------------------
-- The Missing Piece
-- Restores the JST midnight wait before Charlaimagnat hands over the reward.
-- The July 8, 2014 version update shortened the wait to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/43135-Jul-8-2014-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_the_missing_piece', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/outlands/The_Missing_Piece', function(quest)
        local sandoria   = quest.sections[2][xi.zone.NORTHERN_SAN_DORIA]
        local baseTablet = sandoria.onEventFinish[703]

        -- Charlaimagnat studies the tablet overnight. The reward is handed over at JST midnight.
        sandoria.onEventFinish[703] = function(player, csid, option, npc)
            baseTablet(player, csid, option, npc)
            quest:setVar(player, 'Wait', JstMidnight()) -- Module change
        end
    end)
end)
