-----------------------------------
-- Advanced Teamwork
-----------------------------------
-- Log ID: 0, Quest ID: 65
-----------------------------------
-- Vilatroire : !pos -260 -70 423 100
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.ADVANCED_TEAMWORK)

quest.reward =
{
    item  = xi.item.HORN_RING,
    fame  = 80,
    title = xi.title.FIRST_RATE_ORGANIZER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.INTERMEDIATE_TEAMWORK) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WEST_RONFAURE] =
        {
            ['Vilatroire'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getFameLevel(xi.fameArea.SANDORIA) >= 4 and
                        player:getMainLvl() >= 10
                    then
                        return quest:progressEvent(131)
                    else
                        return quest:event(130):replaceDefault()
                    end
                end,
            },

            onEventFinish =
            {
                [131] = function(player, csid, option, npc)
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

        [xi.zone.WEST_RONFAURE] =
        {
            ['Vilatroire'] =
            {
                onTrigger = function(player, npc)
                    local party = player:getParty()

                    if #party > 1 then
                        return quest:progressEvent(129, { [1] = 3 })
                    end
                end,
            },

            onEventUpdate =
            {
                [129] = function(player, csid, option, npc)
                    local partySizeRequirement = 2
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
                end,
            },

            onEventFinish =
            {
                [129] = function(player, csid, option, npc)
                    if option == 0 and quest:getLocalVar(player, 'Prog') == 1 then
                        if quest:complete(player) then
                            quest:setLocalVar(player, 'Prog', 0)
                        end
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WEST_RONFAURE] =
        {
            ['Vilatroire'] = quest:event(130),
        },
    },
}

return quest
