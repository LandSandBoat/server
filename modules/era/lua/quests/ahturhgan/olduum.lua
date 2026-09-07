-----------------------------------
-- Olduum
-- Restores the 24-hour wait for another Olduum Ring.
-- The June 7, 2016 update reduced this to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/50760-Jun.-7-2016-(JST)-Version-Update
-- Source: https://wiki.ffo.jp/html/7472.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_olduum', xi.pre(xi.expansion.ROV))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/ahtUrhgan/Olduum', function(quest)
        local wajaom          = quest.sections[3][xi.zone.WAJAOM_WOODLANDS]
        local baseEventFinish = wajaom.onEventFinish[2]

        wajaom.onEventFinish[2] = function(player, csid, option, npc)
            local previousWait = quest:getVar(player, 'Wait')
            local result       = baseEventFinish(player, csid, option, npc)

            if quest:getVar(player, 'Wait') ~= previousWait then
                quest:setVar(player, 'Wait', GetSystemTime() + 86400) -- Module change
            end

            return result
        end
    end)
end)
