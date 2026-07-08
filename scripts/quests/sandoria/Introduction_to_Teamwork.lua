-----------------------------------
-- Introduction to Teamwork
-----------------------------------
-- Log ID: 0, Quest ID: 63
-----------------------------------
-- Vilatroire : !pos -260 -70 423 100
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.INTRODUCTION_TO_TEAMWORK)

quest.reward =
{
    item  = xi.item.SHELL_RING,
    fame  = 80,
    title = xi.title.THIRD_RATE_ORGANIZER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.WEST_RONFAURE] =
        {
            ['Vilatroire'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getFameLevel(xi.fameArea.SANDORIA) >= 2 and
                        player:getMainLvl() >= 10
                    then
                        return quest:progressEvent(135)
                    else
                        return quest:event(134):replaceDefault()
                    end
                end,
            },

            onEventFinish =
            {
                [135] = function(player, csid, option, npc)
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
                        return quest:progressEvent(129, { [1] = 1 })
                    end
                end,
            },

            onEventUpdate =
            {
                [129] = function(player, csid, option, npc)
                    local partySizeRequirement = 2
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
}

return quest
