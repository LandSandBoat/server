-----------------------------------
-- Let Sleeping Dogs Lie
-----------------------------------
-- Log ID: 2, Quest ID: 46
-- Paku-Nakku      !pos 127.189 -5.750 164.648
-- Pechiru-Mashiru !pos 163.589 -1.249 157.589
-- Maabu-Sonbu     !pos -107.345 -3.250 108.138
-- qm_pepper       !pos -429.603 24.760 473.015
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.LET_SLEEPING_DOGS_LIE)

quest.reward =
{
    item = xi.item.HYPNO_STAFF,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 4
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Paku-Nakku'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(481)
                end,
            },

            ['Akkeke']          = quest:event(484),
            ['Chomoro-Kyotoro'] = quest:event(489),
            ['Foi-Mui']         = quest:event(486),
            ['Kirarara']        = quest:event(485),
            ['Koko_Lihzeh']     = quest:event(488),
            ['Mashuu-Ajuu']     = quest:event(483),
            ['Rukuku']          = quest:event(487),

            onEventFinish =
            {
                [481] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Maabu-Sonbu'] =
            {
                onTrigger = function(player, npc)
                    local option = quest:getVar(player, 'Option')
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:progressEvent(319, 0, xi.item.REMEDY, xi.item.BLAZING_PEPPERS, xi.item.SICKLE)
                    elseif progress == 1 then
                        return quest:event(320, 0, xi.item.REMEDY, xi.item.BLAZING_PEPPERS, xi.item.SICKLE)
                    elseif progress == 2 and option == 1 then
                        return quest:event(321, 0, xi.item.BLAZING_PEPPERS)
                    elseif progress == 2 and option == 2 then
                        return quest:event(321, 0, xi.item.REMEDY)
                    end
                end,
            },

            onEventFinish =
            {
                [319] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {

            ['Akkeke'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress <= 3 then
                        return quest:event(484)
                    elseif progress == 4 then
                        return quest:event(502)
                    end
                end,
            },

            ['Chomoro-Kyotoro'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress <= 3 then
                        return quest:event(489)
                    elseif progress == 4 then
                        return quest:event(507)
                    end
                end,
            },

            ['Fuepepe'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') <= 3 then
                        return quest:event(493)
                    end
                end,
            },

            ['Foi-Mui'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress <= 3 then
                        return quest:event(486)
                    elseif progress == 4 then
                        return quest:event(504)
                    end
                end,
            },

            ['Kirarara'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress <= 3 then
                        return quest:event(485)
                    elseif progress == 4 then
                        return quest:event(503)
                    end
                end,
            },

            ['Koko_Lihzeh'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress <= 3 then
                        return quest:event(488)
                    elseif progress == 4 then
                        return quest:event(506)
                    end
                end,
            },

            ['Mashuu-Ajuu'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress <= 3 then
                        return quest:event(483)
                    elseif progress == 4 then
                        return quest:event(501)
                    end
                end,
            },

            ['Moreno-Toeno'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') <= 3 then
                        return quest:event(491)
                    end
                end,
            },

            ['Paku-Nakku'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress <= 2 then
                        return quest:event(482)
                    elseif progress == 3 then
                        return quest:progressEvent(499)
                    elseif progress == 4 then
                        return quest:event(500)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'Prog') == 1 then
                        if npcUtil.tradeHas(trade, xi.item.BLAZING_PEPPERS) then
                            quest:setVar(player, 'Option', 1) -- Traded Peppers
                            return quest:progressEvent(494, 0, 1)
                        elseif npcUtil.tradeHas(trade, xi.item.REMEDY) then
                            quest:setVar(player, 'Option', 2) -- Traded a Remedy
                            return quest:progressEvent(494)
                        end
                    end
                end,
            },

            ['Pechiru-Mashiru'] =
            {
                onTrigger = function(player, npc)
                    local option = quest:getVar(player, 'Option')
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:event(490)
                    elseif progress == 1 then
                        return quest:event(492)
                    elseif progress == 2 then
                        if option == 1 then
                            return quest:progressEvent(495, 0, xi.item.REMEDY, xi.item.BLAZING_PEPPERS, 1) -- Player had traded Peppers to Paku-Nakku
                        elseif option == 2 then
                            return quest:progressEvent(495, 0, xi.item.REMEDY, xi.item.BLAZING_PEPPERS, 0) -- Player had traded a Remedy to Paku-Nakku
                        end
                    elseif progress == 3 then
                        return quest:event(496)
                    elseif progress == 4 then
                        return quest:progressEvent(497)
                    end
                end,
            },

            ['Rukuku'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress <= 3 then
                        return quest:event(487)
                    elseif progress == 4 then
                        return quest:event(505)
                    end
                end,
            },

            onEventFinish =
            {
                [494] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    player:confirmTrade()
                end,

                [495] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [497] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [499] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },
        },
    },
}

return quest
