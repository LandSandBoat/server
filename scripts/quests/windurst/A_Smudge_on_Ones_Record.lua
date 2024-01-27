-----------------------------------
-- A Smudge on One's Record
-----------------------------------
-- !addquest 2 12
-- Hariga-Origa : !pos -62 -6 105 238
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.A_SMUDGE_ON_ONES_RECORD)

quest.reward =
{
    xp = 2000,
    fame = 120,
    fameArea = xi.quest.fame_area.WINDURST,
    gil = 5000,
    keyItem = xi.ki.MAP_OF_FEIYIN,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CHASING_TALES) and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 4 and
                not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Hariga-Origa'] = quest:progressEvent(413, 0, xi.item.VIAL_OF_SLIME_OIL, xi.item.FROST_TURNIP),

            onEventFinish =
            {
                [413] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Hariga-Origa'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.VIAL_OF_SLIME_OIL, xi.item.FROST_TURNIP }) then
                        return quest:progressEvent(417, quest.reward.gil)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:progressEvent(414, 0, xi.item.VIAL_OF_SLIME_OIL, xi.item.FROST_TURNIP)
                end,
            },

            ['Serukoko'] = quest:progressEvent(415, 0, xi.item.VIAL_OF_SLIME_OIL, xi.item.FROST_TURNIP),

            onEventFinish =
            {
                [417] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        quest:setMustZone(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Hariga-Origa'] = quest:event(418):importantOnce(),
            ['Serukoko']     = quest:event(419):importantOnce(),
        },
    },
}

return quest
