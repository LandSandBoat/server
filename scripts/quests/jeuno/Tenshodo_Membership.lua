-----------------------------------
-- Tenshodo Membership
-----------------------------------
-- Log ID: 3, Quest ID: 17
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.TENSHODO_MEMBERSHIP)

quest.reward =
{
    item = xi.items.TENSHODO_INVITE,
    keyItem = xi.ki.TENSHODO_MEMBERS_CARD,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.JEUNO) >= 3
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Ghebi_Damomohe'] =
            {
                onTrigger = function(player, npc)
                    print("blah")
                    return quest:progressEvent(106)
                end,
            },

            onEventFinish =
            {
                [106] = function(player, csid, option, npc)
                    if option == 2 then
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

        [xi.zone.PORT_BASTOK] =
        {
            ['Jabbar'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.TENSHODO_APPLICATION_FORM) then
                        return quest:progressEvent(152)
                    else
                        return quest:progressEvent(151)
                    end
                end,
            },

            ['Silver_Owl'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.TENSHODO_APPLICATION_FORM) then
                        return quest:progressEvent(152, 1)
                    else
                        return quest:progressEvent(151, 1)
                    end
                end,
            },

            onEventFinish =
            {
                [151] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.keyItem.TENSHODO_APPLICATION_FORM)
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Ghebi_Damomohe'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { xi.items.TENSHODO_INVITE })
                    then
                        return quest:progressEvent(108)
                    end
                end,

                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.keyItem.TENSHODO_APPLICATION_FORM) then
                        return quest:progressEvent(107)
                    -- else
                    --     return quest:progressEvent(106)
                    end
                end,
            },

            onEventFinish =
            {
                [107] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.keyItem.TENSHODO_APPLICATION_FORM)
                    end
                end,

                [108] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        if player:hasKeyItem(xi.keyItem.TENSHODO_APPLICATION_FORM) then
                            player:delKeyItem(xi.keyItem.TENSHODO_APPLICATION_FORM)
                        end

                        player:confirmTrade()
                    end
                end,
            },
        },
    }
}

return quest
