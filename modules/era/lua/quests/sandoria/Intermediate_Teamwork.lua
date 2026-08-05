-----------------------------------
-- Intermediate Teamwork
-- Reverts the required number of same-race party members to six.
-- The May 14, 2015 version update reduced the requirement to two.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/46976
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_quest_intermediate_teamwork'

if xi.module.isContentEnabled('ROV') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/sandoria/Intermediate_Teamwork', function(quest)
        -- Copy of the base handler with partySizeRequirement raised to 6
        quest.sections[2][xi.zone.WEST_RONFAURE].onEventUpdate[129] = function(player, csid, option, npc)
            local partySizeRequirement = 6
            local party = player:getParty()
            local partySameRaceCount = 0

            if #party >= partySizeRequirement then
                for key, member in pairs(party) do
                    if
                        member:getZoneID() ~= player:getZoneID() or
                        member:checkDistance(player) > 15
                    then
                        player:updateEvent(1)
                        return
                    else
                        local pRace = player:getRace()
                        local mRace = member:getRace()

                        if
                            (pRace == xi.race.HUME_M or pRace == xi.race.HUME_F) and
                            (mRace == xi.race.HUME_M or mRace == xi.race.HUME_F)
                        then
                            partySameRaceCount = partySameRaceCount + 1
                        elseif
                            (pRace == xi.race.ELVAAN_M or pRace == xi.race.ELVAAN_F) and
                            (mRace == xi.race.ELVAAN_M or mRace == xi.race.ELVAAN_F)
                        then
                            partySameRaceCount = partySameRaceCount + 1
                        elseif
                            (pRace == xi.race.TARU_M or pRace == xi.race.TARU_F) and
                            (mRace == xi.race.TARU_M or mRace == xi.race.TARU_F)
                        then
                            partySameRaceCount = partySameRaceCount + 1
                        elseif pRace == xi.race.GALKA and mRace == xi.race.GALKA then
                            partySameRaceCount = partySameRaceCount + 1
                        elseif pRace == xi.race.MITHRA and mRace == xi.race.MITHRA then
                            partySameRaceCount = partySameRaceCount + 1
                        end
                    end
                end
            else
                player:updateEvent(1)
                return
            end

            if partySameRaceCount >= partySizeRequirement then
                quest:setLocalVar(player, 'Prog', 1)
                player:updateEvent(15, 2)
                return
            else
                player:updateEvent(4, 2)
                return
            end
        end
    end)
end)

return m
