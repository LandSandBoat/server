-----------------------------------
-- Chasing Quotas (DRG AF2)
-- Restores the JST midnight wait before Ceraulian discovers the mugging.
-- The February 19, 2015 version update shortened the wait to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/46068-Feb-19-2015-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_chasing_quotas', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/sandoria/Chasing_Quotas', function(quest)
        local portSandoria = quest.sections[2][xi.zone.PORT_SAN_DORIA]
        local baseTradeCS  = portSandoria.onEventFinish[17]

        -- The mugging is discovered at JST midnight.
        portSandoria.onEventFinish[17] = function(player, csid, option, npc)
            baseTradeCS(player, csid, option, npc)
            quest:setVar(player, 'Wait', JstMidnight()) -- Module change
        end
    end)
end)
