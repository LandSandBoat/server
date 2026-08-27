-----------------------------------
-- The Gustaberg Tour
-- Reverts the completion requirement to six party members of level five or below.
-- The June 25, 2015 version update reduced it to two members of level fifteen or below.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/47481
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_the_gustaberg_tour', xi.pre(xi.expansion.ROV))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/bastok/The_Gustaberg_Tour', function(quest)
        local northGustaberg = quest.sections[2][xi.zone.NORTH_GUSTABERG]

        -- Copy of the base handler with the level lowered to 5 and the party size raised to 6.
        northGustaberg['Hunting_Bear'].onTrigger = function(player, npc)
            local flag = true

            for _, member in pairs(player:getAlliance()) do
                if
                    member:getMainLvl() > 5 or
                    member:checkDistance(player) > 15
                then
                    flag = false
                end
            end

            if flag and #player:getParty() == 6 then
                return quest:progressEvent(22)
            else
                return quest:progressEvent(21)
            end
        end
    end)
end)
