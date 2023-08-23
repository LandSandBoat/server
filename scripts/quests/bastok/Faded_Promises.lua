-----------------------------------
-- Faded Promises
-----------------------------------
-- Log ID: 1, Quest ID: 73
-- Romualdo : !pos 133 -19 -36 237
-- Ayame    : !pos 133 -19 34 237
-- Kagetora : !pos -96 -2 29 236
-- Alois    : !pos 96 -20 14 237
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.FADED_PROMISES)

quest.reward =
{
    fame     = 10,
    fameArea = xi.quest.fame_area.BASTOK,
    item     = xi.item.FUKURO,
    title    = xi.title.ASSASSIN_REJECT,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.NIN and
                player:getMainLvl() >= 20 and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 4
        end,

        [xi.zone.METALWORKS] =
        {
            ['Romualdo'] = quest:progressEvent(802),

            onEventFinish =
            {
                [802] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Alois'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(805)
                    end
                end,
            },

            ['Ayame'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(803)
                    elseif questProgress == 2 then
                        return quest:progressEvent(804)
                    end
                end,
            },

            onEventFinish =
            {
                [803] = function(player, csid, option, npc)
                    -- This event uses a very big number for cancelation, making the capture suite wrongly return 0.
                    if option == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [804] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [805] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.DIARY_OF_MUKUNDA)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Kagetora'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.DIARY_OF_MUKUNDA) then
                        return quest:progressEvent(296)
                    end
                end,
            },

            onEventFinish =
            {
                [296] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },
}

return quest
