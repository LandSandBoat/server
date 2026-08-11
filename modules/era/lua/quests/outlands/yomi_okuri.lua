-----------------------------------
-- Yomi Okuri (SAM AF2)
-- Restores the JST midnight wait before Jaucribaix hands over the yomotsu hirasaka.
-- The same wait returns before he offers A Thief in Norg!?
-- The July 8, 2014 version update shortened both to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/43135-Jul-8-2014-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_yomi_okuri', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/outlands/SAM_AF2_Yomi_Okuri', function(quest)
        local norg          = quest.sections[2][xi.zone.NORG]
        local baseFeatherCS = norg.onEventFinish[152]

        -- The hirasaka is handed over at JST midnight.
        norg.onEventFinish[152] = function(player, csid, option, npc)
            baseFeatherCS(player, csid, option, npc)
            quest:setVar(player, 'Wait', JstMidnight()) -- Module change
        end

        -- Copy of the base handler. A Thief in Norg!? is offered at JST midnight.
        norg.onEventFinish[156] = function(player, csid, option, npc)
            if quest:complete(player) then
                player:delKeyItem(xi.ki.FADED_YOMOTSU_HIRASAKA)
                xi.quest.setMustZone(player, xi.questLog.OUTLANDS, xi.quest.id.outlands.A_THIEF_IN_NORG)
                xi.quest.setVar(player, xi.questLog.OUTLANDS, xi.quest.id.outlands.A_THIEF_IN_NORG, 'Timer', JstMidnight()) -- Module change
            end
        end
    end)
end)
