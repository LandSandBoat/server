-----------------------------------
-- Revert the requirement of this quest to require 6 members instead of 2.
-- The date this timer changed is approx May 2015: https://ffxiclopedia.fandom.com/wiki/Introduction_to_Teamwork?oldid=1519699
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('Introduction_to_Teamwork')

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/sandoria/Introduction_to_Teamwork', function(quest)
        quest.sections[2][xi.zone.WEST_RONFAURE].onEventUpdate[129] = function(player, status, vars)
            local partySizeRequirement = 6 -- Module change made here from 2 to 6
            local party = player:getParty()
            local partySameNationCount = 0

            if #party >= partySizeRequirement then
                for key, member in pairs(party) do
                    if
                        member:getZoneID() ~= player:getZoneID() or
                        member:checkDistance(player) > 15
                    then
                        player:updateEvent(1)
                        return
                    else
                        if member:getNation() == player:getNation() then
                            partySameNationCount = partySameNationCount + 1
                        end
                    end
                end
            else
                player:updateEvent(1)
                return
            end

            if partySameNationCount >= partySizeRequirement then
                quest:setLocalVar(player, 'Prog', 1)
                player:updateEvent(15, 1)
                return
            else
                player:updateEvent(3, 1)
            end
        end
    end)
end)

return m
