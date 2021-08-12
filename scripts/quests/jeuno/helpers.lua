-- Base class for use by the Gobbiebag questline
local GobbieQuest = {}

setmetatable(GobbieQuest, {__index = Quest} )
GobbieQuest.__index = GobbieQuest

function GobbieQuest:new(params)
    local quest = Quest:new(xi.quest.log_id.JEUNO, params.questId)

    quest.reward = params.reward

    local bagIncrease = 5

    -- If quest is available or accepted, the corect dialogue ID is the expected pre quest inventory size offset by 1
    local getPendingDialogueId = function (player)
        return (player:getContainerSize(xi.inv.INVENTORY) + 1)
    end
    -- If quest is completed, the corect dialogue ID is the expected post quest inventory size offset by 1
    local getCompleteDiaglogueId = function (player)
        return (player:getContainerSize(xi.inv.INVENTORY) + bagIncrease + 1)
    end
    local getReqsMet = function (player)
        return  player:getFameLevel(JEUNO) >= params.fame and
                player:getContainerSize(xi.inv.INVENTORY) == params.startInventorySize and
                (params.prerequisite == nil or player:hasCompletedQuest(xi.quest.log_id.JEUNO, params.prerequisite))
    end

    quest.sections =
    {
        {
            check = function(player, status, vars)
                return status == QUEST_AVAILABLE and getReqsMet(player)
            end,

            [xi.zone.LOWER_JEUNO] =
            {
                ['Bluffnix'] =
                {
                    onTrigger = function(player, npc)
                        return quest:progressEvent(43, getPendingDialogueId(player), QUEST_AVAILABLE, getReqsMet(player) and 1 or 0)
                    end
                },

                onEventFinish = {
                    [43] = function(player, csid, option, npc)
                        if option == 0 then
                            quest:begin(player)
                        end
                    end
                },
            },
        },

        {
            check = function(player, status, vars)
                return status == QUEST_ACCEPTED and getReqsMet(player)
            end,

            [xi.zone.LOWER_JEUNO] = {
                ['Bluffnix'] = {
                    onTrade = function(player, npc, trade)
                        if  npcUtil.tradeHasExactly(trade, params.trade) or
                            npcUtil.tradeHasExactly(trade, xi.items.BOWL_OF_GOBLIN_STEW_880)
                        then
                            return quest:progressEvent(73, getCompleteDiaglogueId(player))
                        else
                            return quest:progressEvent(43, getPendingDialogueId(player), QUEST_ACCEPTED, 1)
                        end
                    end,
                    onTrigger = function(player, npc)
                        return quest:progressEvent(43, getPendingDialogueId(player), QUEST_ACCEPTED, 1)
                    end,
                },

                onEventFinish = {
                [73] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:changeContainerSize(xi.inv.INVENTORY, bagIncrease)
                        player:changeContainerSize(xi.inv.MOGSATCHEL, bagIncrease)
                        player:messageSpecial(lowerJeunoID.text.INVENTORY_INCREASED)
                        player:confirmTrade()
                    end
                end
                },
            },
        },
    }
    self.__index = self
    setmetatable(quest, self)
    return quest
end
