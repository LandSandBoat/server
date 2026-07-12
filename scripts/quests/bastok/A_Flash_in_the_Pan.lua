-----------------------------------
-- A Flash in the Pan
-----------------------------------
-- Log ID: 1, Quest ID: 14
-- Aquillina : !pos -97 -5 -81 235
-----------------------------------
local bastokMarketsID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.A_FLASH_IN_THE_PAN)

quest.reward =
{
    fame     = 75,
    fameArea = xi.fameArea.BASTOK,
    gil      = 100,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Aquillina'] =
            {
                onTrade = function(player, npc, trade)
                    if trade:getItemQty(xi.item.FLINT_STONE) == 0 then
                        return quest:noAction()
                    end

                    if npc:getLocalVar('tradeCooldown') > GetSystemTime() then
                        return quest:event(218)
                    end

                    if npcUtil.tradeHasExactly(trade, { { xi.item.FLINT_STONE, 4 } }) then
                        return quest:progressEvent(219) -- She does NOT care if you ever spoke to her.
                    end
                end,

                onTrigger = function(player, npc)
                    if npc:getLocalVar('tradeCooldown') <= GetSystemTime() then
                        return quest:progressEvent(217)
                    end
                end,
            },

            onEventFinish =
            {
                [217] = function(player, csid, option, npc)
                    quest:begin(player)
                end,

                [219] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        GetNPCByID(bastokMarketsID.npc.AQUILLINA):setLocalVar('tradeCooldown', GetSystemTime() + 900)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status ~= xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Aquillina'] =
            {
                onTrade = function(player, npc, trade)
                    if trade:getItemQty(xi.item.FLINT_STONE) == 0 then
                        return quest:noAction()
                    end

                    if npc:getLocalVar('tradeCooldown') > GetSystemTime() then
                        return quest:event(218)
                    end

                    if npcUtil.tradeHasExactly(trade, { { xi.item.FLINT_STONE, 4 } }) then
                        return quest:progressEvent(219) -- She does NOT care if you ever spoke to her.
                    end
                end,

                onTrigger = function(player, npc)
                    if npc:getLocalVar('tradeCooldown') <= GetSystemTime() then
                        return quest:event(217)
                    end
                end,
            },

            onEventFinish =
            {
                [219] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        GetNPCByID(bastokMarketsID.npc.AQUILLINA):setLocalVar('tradeCooldown', GetSystemTime() + 900)
                    end
                end,
            },
        },
    },
}

return quest
