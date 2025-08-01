-----------------------------------
-- Fit for a Prince
-----------------------------------
-- Log ID: 0, Quest ID: 106
-----------------------------------
-- Halver : !pos 2 0 2 233
-----------------------------------
local ID = zones[xi.zone.CHATEAU_DORAGUILLE]
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.FIT_FOR_A_PRINCE)

local list =
{
    xi.race.HUME_F, xi.race.ELVAAN_F, xi.race.TARU_F, xi.race.MITHRA
}

local checkForMatch = function(player, race, face)
    local party = player:getParty()

    for _, entity in pairs(party) do
        if entity:getRace() == race and entity:getFace() == face then
            entity:addTitle(xi.title.CONSORT_CANDIDATE)
            return true
        end
    end

    return false
end

quest.reward =
{
    item = { xi.item.CASTORS_RING, xi.item.POLLUXS_RING },
    title = xi.title.ROYAL_WEDDING_PLANNER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            xi.settings.main.TESTING_SERVER and
            player:getFameLevel(xi.fameArea.SANDORIA) >= 3 and
            vars.Wait < VanadielUniqueDay()
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    local race = quest:getVar(player, 'Prog')
                    local face = quest:getVar(player, 'Option')
                    if race == 0 then
                        -- Remove your race from list if you are female
                        local newList = {}
                        for i = 1, #list do
                            local playerRace = player:getRace()
                            if playerRace ~= list[i] then
                                table.insert(newList, list[i])
                            end
                        end

                        local newRace = newList[math.random(1, #newList)]
                        local newFace = math.random(0, 15)
                        local firstTime = quest:getVar(player, 'Wait') > 0 and 1 or 0
                        quest:setVar(player, 'Prog', newRace)
                        quest:setVar(player, 'Option', newFace)
                        return quest:event(65, { [0] = newRace, [1] = newFace, [7] = firstTime })
                    else
                        return quest:event(65, { [0] = race, [1] = face, [7] = 1 })
                    end
                end,
            },

            onEventFinish =
            {
                [65] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    local party = player:getParty()
                    local race = quest:getVar(player, 'Prog')
                    local face = quest:getVar(player, 'Option')

                    if #party == 2 and checkForMatch(player, race, face) then
                        return quest:progressEvent(66, { [0] = race, [1] = face })
                    else
                        return quest:event(67, { [0] = race, [1] = face })
                    end
                end,
            },

            onEventUpdate =
            {
                [66] = function(player, csid, option)
                    if option == 0 then
                        -- Some reason only works if the initators charID is lower than the matching charID
                        -- reguardless of party order.
                        -- Bits 3 and 4 seem to be the factor in determining who is shown as initiator and match in retail
                        -- but on private servers changing that for the higher ordered charID if in party changes the entire
                        -- CS into a mix of this quest and another.
                        local party = player:getParty()
                        local members = #party == 2 and 0 or 1

                        -- player:updateEvent(0, 0, 1, 1, 0, 0, 1, members)

                        player:updateEvent(0, 0, 0, 1, 0, 0, 1, members)
                    end
                end,
            },

            onEventFinish =
            {
                [66] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:complete(player)
                    end
                end,

                [67] = function(player, csid, option, npc)
                    -- Cancel Quest, set wait time to restart to next day
                    if option == 1 then
                        quest:setVar(player, 'Prog', 0)
                        quest:setVar(player, 'Option', 0)
                        quest:setVar(player, 'Wait', VanadielUniqueDay())
                        player:delQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.FIT_FOR_A_PRINCE)
                        player:messageSpecial(ID.text.FIT_CANCELED)
                    end
                end,
            },
        },
    },
}

return quest
