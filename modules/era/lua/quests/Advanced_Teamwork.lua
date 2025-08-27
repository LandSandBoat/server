-----------------------------------
-- Revert the requirement of this quest to require 6 members instead of 2.
-- The date this timer changed is approx after May 2015: https://ffxiclopedia.fandom.com/wiki/Advanced_Teamwork?oldid=1519702
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('Advanced_Teamwork')

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/sandoria/Advanced_Teamwork', function(quest)
        quest.sections[2][xi.zone.WEST_RONFAURE].onEventUpdate[129] = function(player, status, vars)
            local partySizeRequirement = 6 -- Module adjustment made here
            local party = player:getParty()
            local partySameJobCount = 0

            if #party >= partySizeRequirement then
                for key, member in pairs(party) do
                    if
                        member:getZoneID() ~= player:getZoneID() or
                        member:checkDistance(player) > 15
                    then
                        player:updateEvent(1)
                        return
                    else
                        if player:getMainJob() == member:getMainJob() then
                            partySameJobCount = partySameJobCount + 1
                        end
                    end
                end
            else
                player:updateEvent(1)
                return
            end

            if partySameJobCount == partySizeRequirement then
                quest:setLocalVar(player, 'Prog', 1)
                player:updateEvent(15, 3)
                return
            else
                player:updateEvent(5, 3)
                return
            end
        end
    end)
end)

return m
