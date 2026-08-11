-----------------------------------
-- Introduction to Teamwork
-- Reverts the required number of same-nation party members to six.
-- The May 14, 2015 version update reduced the requirement to two.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/46976
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_introduction_to_teamwork', xi.pre(xi.expansion.ROV))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/sandoria/Introduction_to_Teamwork', function(quest)
        -- Copy of the base handler with partySizeRequirement raised to 6
        quest.sections[2][xi.zone.WEST_RONFAURE].onEventUpdate[129] = function(player, csid, option, npc)
            local partySizeRequirement = 6
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
