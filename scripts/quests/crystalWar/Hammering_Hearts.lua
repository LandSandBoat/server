-----------------------------------
-- Hammering Hearts
-- !addquest 7 14
-- Scarred Shark: !pos -233.989 -2.000 67.638 87
-- HEAVY_QUADAV_CHESTPLATE: !additem 2504
-- HEAVY_QUADAV_BACKPLATE: !additem 2505
-- TRAINEE_HAMMER: !additem 18855
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.HAMMERING_HEARTS)

quest.reward =
{
    item = xi.item.TRAINEE_HAMMER,
}

quest.sections =
{
    -- Section: Talk to Scarred Shark in Bastok Markets (S) at (G-5) for a cutscene.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Scarred_Shark'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(40)
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- 0: Trade a Heavy Quadav Backplate and a Heavy Quadav Chestplate to Scarred Shark.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 0
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Scarred_Shark'] =
            {
                -- Reminder
                onTrigger = function(player, npc)
                    return quest:progressEvent(43)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.HEAVY_QUADAV_CHESTPLATE, xi.item.HEAVY_QUADAV_BACKPLATE }) then
                        return quest:progressEvent(41)
                    end
                end,
            },

            onEventFinish =
            {
                [41] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 1)
                    player:setLocalVar('Quest[7][14]NeedToZone', 1)
                end,
            },
        },
    },

    -- 1: Zone, then talk to Scarred Shark again for a final cutscene and your reward.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and vars.Prog == 1
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Scarred_Shark'] =
            {
                onTrigger = function(player, npc)
                    if player:getLocalVar('Quest[7][14]NeedToZone') == 1 then
                        return quest:progressEvent(44)
                    else
                        return quest:progressEvent(42)
                    end
                end,
            },

            onEventFinish =
            {
                [42] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },

    -- Section: Quest completed. New default text
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Scarred_Shark'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(45):replaceDefault()
                end,
            },
        },
    },
}

return quest
