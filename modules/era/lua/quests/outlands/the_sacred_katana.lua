-----------------------------------
-- The Sacred Katana (SAM AF1)
-- Restores the JST midnight wait before Jaucribaix offers Yomi Okuri.
-- The July 8, 2014 version update shortened the wait to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/43135-Jul-8-2014-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_the_sacred_katana', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/outlands/SAM_AF1_The_Sacred_Katana', function(quest)
        local norg = quest.sections[2][xi.zone.NORG]

        -- Copy of the base handler. Yomi Okuri is offered at JST midnight.
        norg.onEventFinish[141] = function(player, csid, option, npc)
            if quest:complete(player) then
                player:tradeComplete()
                player:delKeyItem(xi.ki.HANDFUL_OF_CRYSTAL_SCALES)

                -- Player must zone before being able to flag the next quest
                xi.quest.setMustZone(player, xi.questLog.OUTLANDS, xi.quest.id.outlands.YOMI_OKURI)
                xi.quest.setVar(player, xi.questLog.OUTLANDS, xi.quest.id.outlands.YOMI_OKURI, 'Timer', JstMidnight()) -- Module change
            end
        end
    end)
end)
