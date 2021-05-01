-----------------------------------
-- The Pickpocket
-- Miene !pos 0 -4 -81 232
-- Altiret !pos 21 -4 -65 232
-- Adalefont !pos -176 -62 377 100
-- Laillera !pos -127 -62 266 100
-- Colmaie !pos -133 -62 272 100
-- Esca !pos -624 -51 278 100
-----------------------------------
require('scripts/globals/zone')
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_PICKPOCKET)

quest.reward = {
    fame = 30,
    item = xi.items.LIGHT_AXE,
    title = xi.title.PICKPOCKET_PINCHER,
}

quest.sections = {
    -- Section: See initial cutscene with burglar
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and vars.Prog == 0
        end,

        [xi.zone.PORT_SAN_DORIA] = {
            ['Miene'] = quest:progressEvent(502),
            ['Altiret'] = quest:event(559),

            onEventFinish = {
                [502] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Section: Begin quest
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and vars.Prog == 1
        end,

        [xi.zone.PORT_SAN_DORIA] = {
            ['Miene'] = quest:event(554),
            ['Altiret'] = quest:progressEvent(547),

            onEventFinish = {
                [547] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 0)
                end,
            },
        },
    },

    -- Section: Active questing
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_SAN_DORIA] = {
            ['Altiret'] = {
                onTrigger = quest:event(547),

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.GILT_GLASSES) then
                        return quest:progressEvent(550)
                    else
                        return quest:event(551)
                    end
                end,
            },

            ['Miene'] = {
                onTrigger = function(player, npc)
                    local stage = quest:getVar(player, 'Stage')

                    if stage == 0 then
                        if player:getFreeSlotsCount() > 0 then
                            return quest:progressEvent(549)
                        else
                            return quest:event(552)
                        end
                    else
                        if player:getFreeSlotsCount() > 0 and not player:hasItem(xi.items.EAGLE_BUTTON) and not player:hasItem(xi.items.GILT_GLASSES) then
                            -- Reaquire the button
                            return quest:progressEvent(611)
                        else
                            return quest:event(553)
                        end
                    end
                end,
            },

            onEventFinish = {
                [549] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.EAGLE_BUTTON) then
                        quest:setVar(player, 'Stage', 1)
                    end
                end,

                [611] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.items.EAGLE_BUTTON)
                end,

                [550] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },

        [xi.zone.WEST_RONFAURE] = {
            ['Esca'] = {
                onTrigger = function(player, npc, trade)
                    if player:hasItem(xi.items.GILT_GLASSES) then
                        return quest:event(123)
                    else
                        return quest:event(120)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.EAGLE_BUTTON) then
                        return quest:progressEvent(121)
                    end
                end,
            },

            onEventFinish = {
                [121] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.GILT_GLASSES) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    -- Section: Hints during questing
    {
        check = function(player, status, vars)
            return (status == QUEST_AVAILABLE and vars.Prog == 1)
                or (status == QUEST_ACCEPTED and not player:hasItem(xi.items.GILT_GLASSES))
        end,

        -- TODO: all these messages should be moved to IDs file and get updated to new correct values
        [xi.zone.PORT_SAN_DORIA] = {
            ['Laucimercen'] =   quest:message(7608),
            ['Rielle'] =        quest:message(7612),
            ['Maunadolace'] =   quest:message(7872),
            ['Parcarin'] =      quest:message(7794),
            ['Solgierte'] =     quest:message(7797),
            ['Sheridan'] =      quest:message(7828),
            ['Noquerelle'] =    quest:message(7615),
            ['Coribalgeant'] =  quest:message(7631),
            ['Answald'] =       quest:message(7845),
            ['Meuxtajean'] =    quest:message(7618),
            ['Marquie'] =       quest:message(7621),
            ['Avandale'] =      quest:message(7379),
            ['Crilde'] =        quest:message(7623),
            ['Eaugouint'] =     quest:message(7625),
            ['Artinien'] =      quest:message(7854),
            ['Brifalien'] =     quest:message(7855),
            ['Meinemelle'] =    quest:message(7601):oncePerZone(),
            ['Comittie'] =      quest:message(7597):oncePerZone(),
        },
        [xi.zone.NORTHERN_SAN_DORIA] = {
            ['Pepigort'] =      quest:message(11467),
            ['Guilberdrier'] =  quest:message(11463),
            ['Gilipese'] =      quest:message(11468),
            ['Aurege'] =        quest:message(11461):importantOnce(),
            ['Rodaillece'] =    quest:message(11472):importantOnce(),
            ['Maurinne'] =      quest:sequence({ text = 11470, wait = 1000 }, { text = 11471, face = 82, wait = 2000 }, { face = 115 }),
        },
        [xi.zone.WEST_RONFAURE] = {
            ['Colmaie'] =       quest:message(7334),
            ['Laillera'] =      quest:message(7335),
            ['Adalefont'] =     quest:message(7336),
        },
    },

    -- Section: Completed quest
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_SAN_DORIA] = {
            ['Altiret'] = quest:event(580),
        },

        [xi.zone.WEST_RONFAURE] = {
            ['Esca'] = quest:event(123),
        },
    },
}


return quest
