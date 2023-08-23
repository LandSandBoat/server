-----------------------------------
-- Gourmet
-----------------------------------
-- Log ID: 1, Quest ID: 12
-- Salimah : !pos -173 -5 64 235
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.GOURMET)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    title    = xi.title.MOMMYS_HELPER,
}

-- Table Format: { eventId, timeMin, timeMax }
-- NOTE: In order to iterate through these without having to change conditional
-- logic, all time comparisons are 6 less than the actual time.
local tradeItemData =
{
    [xi.item.SLEEPSHROOM] = { 201, 12, 24 }, -- 18:00 ~ 06:00
    [xi.item.TREANT_BULB] = { 201,  0,  6 }, -- 06:00 ~ 12:00
    [xi.item.WILD_ONION]  = { 202,  6, 12 }, -- 12:00 ~ 18:00
}

local function tradeEventFinish(player, gilReward, additionalFame)
    if quest:complete(player) then
        player:confirmTrade()

        npcUtil.giveCurrency(player, 'gil', gilReward)
        player:addFame(xi.quest.fame_area.BASTOK, additionalFame)
        quest:setMustZone(player)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Salimah'] = quest:progressEvent(200),

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status >= QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Salimah'] =
            {
                onTrade = function(player, npc, trade)
                    for itemId, itemData in pairs(tradeItemData) do
                        if npcUtil.tradeHasExactly(trade, itemId) then
                            local timeOffset = VanadielHour() - 6

                            if timeOffset < 0 then
                                timeOffset = 24 + timeOffset
                            end

                            if
                                timeOffset >= itemData[2] and
                                timeOffset < itemData[3]
                            then
                                return quest:progressEvent(itemData[1], itemId)
                            else
                                return quest:progressEvent(203, itemId)
                            end
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    if not quest:getMustZone(player) then
                        return quest:event(200)
                    else
                        return quest:event(121)
                    end
                end,
            },

            onEventFinish =
            {
                [201] = function(player, csid, option, npc)
                    tradeEventFinish(player, 200, 30)
                end,

                [202] = function(player, csid, option, npc)
                    tradeEventFinish(player, 350, 90)
                end,

                [203] = function(player, csid, option, npc)
                    tradeEventFinish(player, 100, 0)
                end,
            },
        },
    },
}

return quest
