-----------------------------------
-- Wonder Wands
-----------------------------------
-- !addquest 2 48
-- Hakkuru-Rinkuru : !pos -111 -4 101 240
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WONDER_WANDS)

quest.reward =
{
    fame     = 150,
    fameArea = xi.quest.fame_area.WINDURST,
    title    = xi.title.DOCTOR_SHANTOTTOS_GUINEA_PIG,
    item     = xi.items.NEW_MOON_ARMLETS,
    gil      = 4800,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_AMENS) and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 5 and
                not player:needToZone()
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] = quest:progressEvent(259),

            onEventFinish =
            {
                [259] = function(player, csid, option, npc)
                    if option == 1 then
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

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.items.OAK_STAFF, xi.items.MYTHRIL_ROD, xi.items.ROSE_WAND }) then
                        return quest:progressEvent(265, 0, xi.items.OAK_STAFF, xi.items.MYTHRIL_ROD, xi.items.ROSE_WAND)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(260, 0, xi.items.OAK_STAFF, xi.items.MYTHRIL_ROD, xi.items.ROSE_WAND)
                end,
            },

            ['Goltata']        = quest:event(257, 0, 0, xi.items.OAK_STAFF),
            ['Yaman-Hachuman'] = quest:event(256, 0, 0, 0, xi.items.MYTHRIL_ROD),
            ['Ohruru']         = quest:event(258, 0, xi.items.ROSE_WAND),

            onEventFinish =
            {
                [265] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and player:getCharVar("[2][48]rewardExtra") == 0
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] = quest:progressEvent(267),

            onEventFinish =
            {
                [267] = function(player, csid, option, npc)
                    local wands =
                    {
                        xi.items.MYTHRIL_ROD,
                        xi.items.OAK_STAFF,
                        xi.items.ROSE_WAND,
                    }

                    table.remove(wands, math.random(1, #wands))

                    if npcUtil.giveItem(player, wands) then
                        player:setCharVar("[2][48]rewardExtra", 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Goltata']        = quest:event(269):importantOnce(),
            ['Yaman-Hachuman'] = quest:event(268):importantOnce(),
            ['Ohruru']         = quest:event(265):importantOnce(),
        },
    },
}

return quest
