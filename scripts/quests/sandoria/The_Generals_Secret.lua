-----------------------------------
-- A Sentry's Peril
-- !addquest 0 60
-- Curilla : !pos 27 0.1 0.1 233
-- Hot Springs : !pos 444 -37 -18 139
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_GENERALS_SECRET)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    item = xi.item.LYNX_BAGHNAKHS,
}

quest.sections =
{
    {
        check = function(player, status)
            return status == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.SANDORIA) > 1
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Curilla'] = quest:progressEvent(55),

            onEventFinish =
            {
                [55] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.CURILLAS_BOTTLE_EMPTY)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Curilla'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.CURILLAS_BOTTLE_FULL) then
                        return quest:progressEvent(54)
                    else
                        return quest:progressEvent(53)
                    end
                end,
            },

            onEventFinish =
            {
                [54] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.CURILLAS_BOTTLE_FULL)
                    end
                end,
            },
        },

        [xi.zone.HORLAIS_PEAK] =
        {
            ['Hot_Springs'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.CURILLAS_BOTTLE_EMPTY) then
                        player:delKeyItem(xi.ki.CURILLAS_BOTTLE_EMPTY)
                        return quest:keyItem(xi.ki.CURILLAS_BOTTLE_FULL)
                    end
                end,
            },
        },
    },
}

return quest
