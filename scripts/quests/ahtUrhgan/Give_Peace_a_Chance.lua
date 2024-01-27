-----------------------------------
-- Give Peace a Chance
-- Mishhar, Whitegate , !pos -12 -6 29 50
-- QM8, Wajaom Woodlands, !pos 416 -24 220 51
-- QM4, Mamook, !pos 347 -12 -256 65
-----------------------------------
-- require('cripts/globals/weather')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.GIVE_PEACE_A_CHANCE)

quest.reward =
{
    item = xi.item.IMPERIAL_SILVER_PIECE,
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Mishhar'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(562)
                end,
            },

            onEventFinish =
            {
                [562] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Mishhar'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(587)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(575)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:event(588)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(576)
                    end
                end,
            },

            onEventFinish =
            {
                [575] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [576] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:needToZone(true)
                        player:setVar('Quest[6][30]Stage', getMidnight())
                    end
                end,
            },
        },

        [xi.zone.WAJAOM_WOODLANDS] =
        {
            ['qm8'] =
            {
                onTrigger = function(player, npc)
                    if VanadielTOTD() == xi.time.NIGHT and quest:getVar(player, 'Prog') == 0 then
                        return quest:progressCutscene(504)
                    end
                end,
            },

            onEventFinish =
            {
                [504] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.MAMOOK] =
        {
            ['qm4'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressCutscene(211)
                    end
                end,
            },

            onEventFinish =
            {
                [211] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },
}

return quest
