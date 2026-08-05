-----------------------------------
-- Advanced Teamwork
-- Reverts the required number of same-job party members to six.
-- The May 14, 2015 version update reduced the requirement to two.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/46976
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_quest_advanced_teamwork'

if xi.module.isContentEnabled('ROV') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/sandoria/Advanced_Teamwork', function(quest)
        -- Copy of the base handler with partySizeRequirement raised to 6
        quest.sections[2][xi.zone.WEST_RONFAURE].onEventUpdate[129] = function(player, csid, option, npc)
            local partySizeRequirement = 6
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
