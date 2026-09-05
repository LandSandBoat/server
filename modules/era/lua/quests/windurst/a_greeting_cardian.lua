-----------------------------------
-- A Greeting Cardian
-- Restores the JST midnight wait before Kororo offers the quest.
-- The July 8, 2014 version update shortened the wait to one minute.
-- The zone change after the teaching is still live on retail. It stays in the base script.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/43135-Jul-8-2014-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_a_greeting_cardian', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/windurst/A_Greeting_Cardian', function(quest)
        local woods       = quest.sections[1][xi.zone.WINDURST_WOODS]
        local baseTeachCS = woods.onEventFinish[295]

        -- Kororo makes the offer at JST midnight, after the zone change.
        woods.onEventFinish[295] = function(player, csid, option, npc)
            baseTeachCS(player, csid, option, npc)
            quest:setVar(player, 'Wait', JstMidnight()) -- Module change
        end
    end)
end)
