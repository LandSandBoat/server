-----------------------------------
-- Return to the Depths
-- Ayame
-- Log ID = 1
-- Quest ID = 78
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/titles')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.RETURN_TO_THE_DEPTHS)

quest.reward =
{
    fame     = 60,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.items.BOWYER_RING,
    title    = xi.title.GOBLIN_IN_DISGUISE,
}

quest.sections =
{
    -- Available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.BASTOK) >= 5 and
            player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_QUESTION_OF_FAITH)
        end,

        [xi.zone.METALWORKS] =
        {
            ['Ayame'] = quest:progressEvent(879),

            onEventFinish =
            {
                [879] = function(player, csid, option, npc)
                        quest:begin(player)
                end,
            },
        },
    },

    -- Accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Ayame'] =
            {
                onTrigger = function(player, csid, option, npc)
                    if quest:getVar(player, 'prog') == 10 then
                        return quest:progressEvent(881)
                    end
                end,
            },

            onEventFinish =
            {
                [881] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Tarnotik'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'prog') == 6 then
                        return quest:progressEvent(42, 0, 0, 0, 0, xi.items.BULB_OF_MISAREAUX_GARLIC)
                    elseif quest:getVar(player, 'prog') == 7 then
                        return quest:progressEvent(43)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.BOTTLE_OF_AHRIMAN_TEARS) and
                    quest:getVar(player, 'prog') == 7 then
                        return quest:progressEvent(44)
                    end
                end,
            },

            afterZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'prog') == 0 then
                        return quest:progressEvent(40, 0, xi.items.SPRIG_OF_FRESH_MUGWORT, xi.items.MOORISH_IDOL, xi.items.PIECE_OF_ANGEL_SKIN, xi.items.BULB_OF_MISAREAUX_GARLIC)
                    elseif quest:getVar(player, 'prog') == 5 then
                        return quest:progressEvent(41)
                    end
                end,
            },

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    quest:setVar(player, 'prog', 1)
                end,

                [41] = function(player, csid, option, npc)
                    quest:setVar(player, 'prog', 6)
                end,

                [42] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'prog', 7)
                    end
                end,

                [44] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'prog', 8)
                    xi.teleport.to(player, xi.teleport.id.MINESHAFT)
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Muckvix'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.BULB_OF_MISAREAUX_GARLIC) and
                    quest:getVar(player, 'prog') == 1 then
                        return quest:progressEvent(99, 0, 0, 0, 0, xi.items.BULB_OF_MISAREAUX_GARLIC)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'prog') == 2 then
                        return quest:progressEvent(46)
                    elseif quest:getVar(player, 'prog') == 4 then
                        return quest:progressEvent(100)
                    end
                end,
            },

            onEventFinish =
            {
                [99] = function(player, csid, option, npc)
                    player:tradeComplete()
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_MUCKVIX)
                    npcUtil.giveCurrency(player, "gil", 2000)
                    quest:setVar(player, 'prog', 2)
                end,

                [100] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.PROVIDENCE_POT)
                    player:delKeyItem(xi.ki.LETTER_FROM_MAGRIFFON)
                    player:delKeyItem(xi.ki.LETTER_FROM_MUCKVIX)
                    player:messageSpecial(zones[player:getZoneID()].text.KEYITEM_LOST, xi.ki.PROVIDENCE_POT)
                    player:messageSpecial(zones[player:getZoneID()].text.KEYITEM_LOST, xi.ki.LETTER_FROM_MAGRIFFON)
                    player:messageSpecial(zones[player:getZoneID()].text.KEYITEM_LOST, xi.ki.LETTER_FROM_MUCKVIX)
                    npcUtil.giveKeyItem(player, xi.ki.PUNGENT_PROVIDENCE_POT)
                    quest:setVar(player, 'prog', 5)
                end,
            },
        },

        [xi.zone.KAZHAM] =
        {
            ['Magriffon'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'prog') == 2 then
                        return quest:progressEvent(299, 0, xi.ki.PROVIDENCE_POT, 10000)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { "gil", 10000 } } ) and
                    quest:getVar(player, 'prog') == 3 then
                        return quest:progressEvent(301, 0, xi.ki.PROVIDENCE_POT, 10000)
                    end
                end,
            },

            onEventFinish =
            {
                [299] = function(player, csid, option, npc)
                    quest:setVar(player, 'prog', 3)
                end,

                [301] = function(player, csid, option, npc)
                    player:tradeComplete()
                    npcUtil.giveKeyItem(player, { xi.ki.PROVIDENCE_POT, xi.ki.LETTER_FROM_MAGRIFFON })
                    quest:setVar(player, 'prog', 4)
                end,
            },
        },

        [xi.zone.MINE_SHAFT_2716] =
        {
            ['_0d0'] = -- Mine Shaft BCNM Entrance
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'prog') == 8 then
                        return quest:progressEvent(5, 0, 0, 0, 0, xi.items.BULB_OF_MISAREAUX_GARLIC)
                    end
                end,
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    quest:setVar(player, 'prog', 9)
                end,
            },
        },
    },

    -- Completed
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Ravorara'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.PUNGENT_PROVIDENCE_POT) then
                        return quest:progressEvent(313, 0, 0, 0, xi.ki.PUNGENT_PROVIDENCE_POT)
                    else
                        return quest:event(314)
                    end
                end,
            },

            onEventFinish =
            {
                [313] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.PUNGENT_PROVIDENCE_POT)
                        player:messageSpecial(zones[player:getZoneID()].text.KEYITEM_LOST, xi.ki.PUNGENT_PROVIDENCE_POT)
                        npcUtil.giveCurrency(player, "gil", 1000)
                    end
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Tarnotik'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(43)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.BOTTLE_OF_AHRIMAN_TEARS) then
                        return quest:progressEvent(44)
                    end
                end,
            },

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    player:tradeComplete()
                    xi.teleport.to(player, xi.teleport.id.MINESHAFT)
                end,
            },
        },
    },
}

return quest
