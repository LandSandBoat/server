-----------------------------------
-- Module to change the party size requirements in 'The Kuftal Tour' quest to 6.
-- Originally this quest required 6 players, but was dropped to 2 with the June 2015 Update https://forum.square-enix.com/ffxi/threads/47481-Jun-25-2015-%28JST%29-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('the_kuftal_tour')

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/outlands/The_Kuftal_Tour', function(quest)
        quest.sections[2][xi.zone.KUFTAL_TUNNEL]['qm5'].onTrigger = function(player, npc)
            local flag = true

            for _, member in pairs(player:getAlliance()) do
                if
                    member:getMainLvl() > 40 or
                    member:checkDistance(player) > 15
                then
                    flag = false
                end
            end

            if flag and #player:getParty() == 6 then
                return quest:progressEvent(14)
            end
        end
    end)
end)

return m
