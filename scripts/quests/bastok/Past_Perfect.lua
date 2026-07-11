-----------------------------------
-- Past Perfect
-----------------------------------
-- Log ID: 1, Quest ID: 23
-- Evi : !pos -4.656 -2.101 1.664 236
-- qm2 : !pos -201 16 80 108
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.PAST_PERFECT)

quest.reward =
{
    item     = xi.item.SCALE_MAIL,
    fame     = 110,
    fameArea = xi.fameArea.BASTOK,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.BASTOK) >= 2
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Evi'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(21)
                    else
                        return quest:progressEvent(130)
                    end
                end,
            },

            onEventFinish =
            {
                [21] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [130] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.KONSCHTAT_HIGHLANDS] =
        {
            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.TATTERED_MISSION_ORDERS) then
                        return quest:keyItem(xi.ki.TATTERED_MISSION_ORDERS)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Evi'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.TATTERED_MISSION_ORDERS) then
                        return quest:progressEvent(131)
                    else
                        return quest:event(104)
                    end
                end,
            },

            onEventFinish =
            {
                [131] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.TATTERED_MISSION_ORDERS)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Evi'] =
            {
                onTrigger = function(player, npc)
                    if player:getLocalVar('EviDialog') == 0 then
                        return quest:progressEvent(21)
                    else
                        return quest:event(104)
                    end
                end,
            },

            onEventFinish =
            {
                [21] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },
}

return quest
