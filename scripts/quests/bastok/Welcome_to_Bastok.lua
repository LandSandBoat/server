-----------------------------------
-- Welcome to Bastok
-----------------------------------
-- Log ID: 1, Quest ID: 2
-- Powhatan   : !pos -152.135 -7.48 19.014 236
-- Bartolomeo : !pos -84.967 1.896 -18.679 236
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WELCOME_TO_BASTOK)

quest.reward =
{
    fame     = 80,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.item.SPATHA,
    title    = xi.title.BASTOK_WELCOMING_COMMITTEE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Powhatan'] = quest:progressEvent(50),

            onEventFinish =
            {
                [50] = function(player, csid, option, npc)
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

        [xi.zone.PORT_BASTOK] =
        {
            ['Powhatan'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:event(51)
                    elseif questProgress == 1 then
                        return quest:progressEvent(53)
                    end
                end,
            },

            ['Bartolomeo'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getEquipID(xi.slot.SUB) == xi.item.SHELL_SHIELD and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return quest:progressEvent(52)
                    end
                end,
            },

            onEventFinish =
            {
                [52] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [53] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
