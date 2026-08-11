-----------------------------------
-- A Thief in Norg!? (SAM AF3)
-- Restores the JST midnight wait before Jaucribaix repairs the charred helm.
-- The July 8, 2014 version update shortened the wait to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/43135-Jul-8-2014-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_a_thief_in_norg', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/outlands/SAM_AF3_A_Thief_in_Norg', function(quest)
        local norg         = quest.sections[2][xi.zone.NORG]
        local baseThreadCS = norg.onEventFinish[162]

        -- The helm is repaired at JST midnight.
        norg.onEventFinish[162] = function(player, csid, option, npc)
            baseThreadCS(player, csid, option, npc)
            quest:setVar(player, 'Wait', JstMidnight()) -- Module change
        end
    end)
end)
