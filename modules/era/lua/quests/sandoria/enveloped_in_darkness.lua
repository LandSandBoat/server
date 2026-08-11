-----------------------------------
-- Enveloped in Darkness (RDM AF2)
-- Restores the JST midnight wait for the boots and crawler blood buried
-- at the digging spot in the Crawlers' Nest.
-- The June 17, 2014 version update shortened the wait to about 30 seconds.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/42614-Jun-17-2014-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_enveloped_in_darkness', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/sandoria/RDM_AF2_Enveloped_in_Darkness', function(quest)
        local crawlersNest = quest.sections[2][xi.zone.CRAWLERS_NEST]

        -- Copy of the base handler with the 30 second wait extended to JST midnight.
        crawlersNest.onEventFinish[4] = function(player, csid, option, npc)
            if option == 1 then
                -- Set purification time.
                quest:setVar(player, 'Time', JstMidnight()) -- Module change: the boots are purified at JST midnight.

                -- Delete Key items.
                player:delKeyItem(xi.ki.CRAWLER_BLOOD)
                player:delKeyItem(xi.ki.OLD_BOOTS)

                -- Message when acepting to bury boots and blood.
                player:messageSpecial(zones[xi.zone.CRAWLERS_NEST].text.YOU_BURY_THE, xi.ki.OLD_BOOTS, xi.ki.CRAWLER_BLOOD)
            end
        end
    end)
end)
