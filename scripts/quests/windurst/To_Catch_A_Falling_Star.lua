-----------------------------------
-- To Catch A Falling Star
-----------------------------------
-- !addquest 2 53
-- Sigismund : !pos -110 -9 80 206
-----------------------------------
require('scripts/globals/interaction/quest')
require("scripts/globals/npc_util")
require('scripts/globals/quests')
require('scripts/globals/zone')

local westSaruIDs = require("scripts/zones/West_Sarutabaruta/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TO_CATCH_A_FALLING_STAR)

quest.reward =
{
    fame = 75,
    fameArea = xi.quest.fame_area.WINDURST,
    item = xi.items.FISH_SCALE_SHIELD
}

quest.sections =
{
    -- Quest Acceptance
    {
        check = function(player, status, vars)
           return status == QUEST_AVAILABLE
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Sigismund'] = quest:progressEvent(196, 0, xi.items.STARFALL_TEAR),

            onEventFinish =
            {
                [196] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            -- Supporting Character dialogue after Accepted
            ['Tohopka'] = quest:event(198, 0, xi.items.STARFALL_TEAR, xi.items.HANDFUL_OF_PUGIL_SCALES),

            -- Quest Completion
            ['Sigismund'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(197, 0, xi.items.STARFALL_TEAR)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.STARFALL_TEAR, 1 } }) then
                        return quest:progressEvent(199)
                    end
                end
            },

            onEventFinish =
            {
                [199] = function(player, csid, option, npc)
                    -- quest:complete() will clear this quest's variables
                    if quest:complete(player) then
                        player:tradeComplete()
                        -- Re-establish the Prog variable so Sigismund provides his After completion text
                        quest:setVar(player, 'Prog', 2)
                    end
                end
            }
        },

        -- Twinkle Tree in West Saru.
        [xi.zone.WEST_SARUTABARUTA] =
        {
            ['Twinkle_Tree'] =
            {
                onTrigger = function(player, npc)
                    if VanadielHour() <= 3 then
                        player:messageSpecial(westSaruIDs.text.FROST_DEPOSIT_TWINKLES)
                        return quest:messageSpecial(westSaruIDs.text.MELT_BARE_HANDS)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        VanadielHour() <= 3 and
                        npcUtil.tradeHasExactly(trade, { { xi.items.HANDFUL_OF_PUGIL_SCALES, 1 } }) and
                        npcUtil.giveItem(player, xi.items.STARFALL_TEAR)
                    then
                        player:confirmTrade()
                        if quest:getVar(player, 'Prog') == 0 then
                            quest:setVar(player, 'Prog', 1)
                        end
                        player:messageSpecial(westSaruIDs.text.FROST_DEPOSIT_TWINKLES)
                        return quest:messageSpecial(westSaruIDs.text.MELT_BARE_HANDS)
                    end
                end
            }
        },
    },

    -- After Quest Complete
    {
        check = function(player, status, vars)
            return
                status == QUEST_COMPLETED and
                vars.Prog > 0
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Sigismund'] = quest:progressEvent(200),

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    -- Clear the Prog variable so this event only fires once
                    quest:setVar(player, 'Prog', 0)
                end
            }
        }
    },
}

return quest
