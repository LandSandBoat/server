-----------------------------------
-- The Brugaire Consortium
-----------------------------------
-- Log ID: 0, Quest ID: 12
-- Fontoumant : !pos -10 -10 -122 232
-- Regine     : !pos 68 -9 -74 232
-- Apstaule   : !pos -6.983 -13.3 -157.517
-- Thierride  : !pos -67 -5 -28 232
-----------------------------------

---@type TQuest
local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.SANDORIA,
    item     = xi.item.LAUAN_SHIELD,
    title    = xi.title.COURIER_EXTRAORDINAIRE,
}

-- NOTE: Event Ids in Index 1 are for the next event (Option), while item is
-- used by quest progress (Prog)
local parcelItemIds =
{
    [0] = { 511, xi.item.PARCEL_FOR_THE_MAGIC_SHOP    },
    [1] = { 512, xi.item.PARCEL_FOR_THE_AUCTION_HOUSE },
    [2] = { 515, xi.item.PARCEL_FOR_THE_PUB           },
}

local tradeOnEventFinish = function(player, csid, option, npc)
    player:confirmTrade()
    quest:incrementVar(player, 'Prog', 1)
end

local triggerOnEventFinish = function(player, csid, option, npc)
    if npcUtil.giveItem(player, parcelItemIds[quest:getVar(player, 'Prog')][2]) then
        quest:incrementVar(player, 'Option', 1)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Fontoumant'] = quest:progressEvent(509),

            onEventFinish =
            {
                [509] = function(player, csid, option, npc)
                    if
                        option == 0 and
                        npcUtil.giveItem(player, xi.item.PARCEL_FOR_THE_MAGIC_SHOP)
                    then
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

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Fontoumant'] =
            {
                onTrade = function(player, npc, trade)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress < 3 and
                        questProgress == quest:getVar(player, 'Option') and
                        npcUtil.tradeHasExactly(trade, { { 'gil', 100 } })
                    then
                        return quest:progressEvent(608 + questProgress)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')
                    local questOption   = quest:getVar(player, 'Option')

                    if questProgress > questOption then
                        return quest:progressEvent(parcelItemIds[questOption][1])
                    else
                        return quest:event(560)
                    end
                end,
            },

            ['Regine'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        npcUtil.tradeHasExactly(trade, xi.item.PARCEL_FOR_THE_MAGIC_SHOP)
                    then
                        return quest:progressEvent(535)
                    end
                end,
            },

            ['Apstaule'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeHasExactly(trade, xi.item.PARCEL_FOR_THE_AUCTION_HOUSE)
                    then
                        return quest:progressEvent(540)
                    end
                end,
            },

            ['Thierride'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        npcUtil.tradeHasExactly(trade, xi.item.PARCEL_FOR_THE_PUB)
                    then
                        return quest:progressEvent(539)
                    end
                end,
            },

            onEventFinish =
            {
                [511] = triggerOnEventFinish,
                [512] = triggerOnEventFinish,

                [515] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [535] = tradeOnEventFinish,
                [539] = tradeOnEventFinish,
                [540] = tradeOnEventFinish,
                [608] = tradeOnEventFinish,
                [609] = tradeOnEventFinish,
                [610] = tradeOnEventFinish,
            },
        },
    },
}

return quest
