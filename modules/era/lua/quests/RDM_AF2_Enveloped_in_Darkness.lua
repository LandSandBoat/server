-----------------------------------
-- Revert the timer for the quest: "Your Crystal Ball" to JP midnight.
-- The date this timer changed is approx October 2015: https://ffxiclopedia.fandom.com/wiki/Your_Crystal_Ball?oldid=1542116
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('RDM_AF2_Enveloped_in_Darkness')

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/sandoria/RDM_AF2_Enveloped_in_Darkness', function(quest)
        quest.sections[2][xi.zone.CRAWLERS_NEST]['qm8'].onEventFinish = function(player, csid, option, npc)
            if option == 1 then
                quest:setVar(player, 'Time', JstMidnight()) -- Timer adjustment made here
                player:delKeyItem(xi.ki.CRAWLER_BLOOD)
                player:delKeyItem(xi.ki.OLD_BOOTS)
                player:messageSpecial(zones[xi.zone.CRAWLERS_NEST].text.YOU_BURY_THE, xi.ki.OLD_BOOTS, xi.ki.CRAWLER_BLOOD)
            end
        end
    end)
end)

return m
