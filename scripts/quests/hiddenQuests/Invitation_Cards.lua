-----------------------------------
-- Lure of the Wildcat Invitation Cards

-- Naja: !pos 22.700 -8.804 -45.591 50
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
require('scripts/globals/interaction/hidden_quest')
-----------------------------------

local quest = HiddenQuest:new("Invitation_Cards")

local invitationCards =
{
    xi.ki.RED_INVITATION_CARD,
    xi.ki.BLUE_INVITATION_CARD,
    xi.ki.GREEN_INVITATION_CARD,
    xi.ki.WHITE_INVITATION_CARD,
}

local rewards =
{
    [0] = { coin = 0,                               amount = 0 },
    [1] = { coin = xi.items.IMPERIAL_BRONZE_PIECE,  amount = 1 },
    [2] = { coin = xi.items.IMPERIAL_BRONZE_PIECE,  amount = 2 },
    [3] = { coin = xi.items.IMPERIAL_BRONZE_PIECE,  amount = 3 },
    [4] = { coin = xi.items.IMPERIAL_MYTHRIL_PIECE, amount = 1 },
}

local function getCards(player)
    local numCards = 0

    for _, tempKeyItem in pairs(invitationCards) do
        if player:hasKeyItem(tempKeyItem) then
            numCards = numCards + 1
        end
    end

    return numCards, rewards[numCards].coin, rewards[numCards].amount
end

local function deleteCards(player)
    for _, tempKeyItem in pairs(invitationCards) do
        if player:hasKeyItem(tempKeyItem) then
            player:delKeyItem(tempKeyItem)
        end
    end
end

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return getCards(player) > 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    if quest:getLocalVar(player, 'Option') == 0 then
                        if quest:getVar(player, 'Prog') == 0 then
                            return quest:progressEvent(74, { text_table = 0 })
                        else
                            return quest:progressEvent(75, { text_table = 0 })
                        end
                    end
                end,
            },

            onEventUpdate =
            {
                [74] = function(player, csid, option, npc)
                    if option == 1 then
                        local cards, coin, amount = getCards(player)

                        player:updateEvent({ [0] = cards, [1] = coin, [2] = amount, text_table = 0 })
                    end
                end,

                [75] = function(player, csid, option, npc)
                    if option == 1 then
                        local cards, _, _ = getCards(player)

                        player:updateEvent({ [0] = cards, [1] = xi.items.IMPERIAL_BRONZE_PIECE, [2] = 1, text_table = 0 })
                    end
                end,
            },

            onEventFinish =
            {
                [74] = function(player, csid, option, npc)
                    quest:setLocalVar(player, 'Option', 1)

                    if option == 3 then
                        local cards, coin, amount = getCards(player)

                        if npcUtil.giveItem(player, { { coin, amount } }) then
                            deleteCards(player)

                            if cards < 4 then
                                quest:setVar(player, 'Prog', cards)
                            end
                        end
                    end
                end,

                [75] = function(player, csid, option, npc)
                    quest:setLocalVar(player, 'Option', 1)

                    if option == 3 then
                        local cards, _, _ = getCards(player)

                        if npcUtil.giveItem(player, xi.items.IMPERIAL_BRONZE_PIECE) then
                            deleteCards(player)

                            local count = quest:getVar(player, 'Prog')
                            if cards + count >= 4 then
                                quest:complete(player)
                            else
                                quest:setVar(player, 'Prog', count + cards)
                            end
                        end
                    end
                end,
            },
        },
    },
}

return quest
