-----------------------------------
-- The Pickpocket
-- Miene !pos 0 -4 -81 232
-- Altiret !pos 21 -4 -65 232
-- Esca !pos -624 -51 278 100
-----------------------------------
local portSandOriaID     = zones[xi.zone.PORT_SAN_DORIA]
local northernSandOriaID = zones[xi.zone.NORTHERN_SAN_DORIA]
local westRonfaureID     = zones[xi.zone.WEST_RONFAURE]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_PICKPOCKET)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    item = xi.item.LIGHT_AXE,
    itemParams = { fromTrade = true },
    title = xi.title.PICKPOCKET_PINCHER,
}

quest.sections =
{
    -- Speaking with the little elvaan girl, Miene, will activate a cutscene. You will see a burglar steal something from Altiret, one of the guards.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and vars.Prog == 0
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Miene'] = quest:progressEvent(502),

            onEventFinish =
            {
                [502] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Informational: You can talk to nearby guards and by-standers, some will report having seen the thief allowing you to pick up the trail.
    {
        check = function(player, status, vars)
            return
                (status == QUEST_AVAILABLE and vars.Prog == 1) or
                (status == QUEST_ACCEPTED and not player:hasItem(xi.item.GILT_GLASSES))
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Answald'] =       quest:message(portSandOriaID.text.PICKPOCKET_ANSWALD),
            ['Artinien'] =      quest:message(portSandOriaID.text.PICKPOCKET_ARTINIEN),
            ['Avandale'] =      quest:message(portSandOriaID.text.PICKPOCKET_AVANDALE),
            ['Brifalien'] =     quest:message(portSandOriaID.text.PICKPOCKET_BRIFALIEN),
            ['Comittie'] =      quest:message(portSandOriaID.text.PICKPOCKET_COMITTIE):oncePerZone(),
            ['Coribalgeant'] =  quest:message(portSandOriaID.text.PICKPOCKET_CORIBALGEANT),
            ['Crilde'] =        quest:message(portSandOriaID.text.PICKPOCKET_CRILDE),
            ['Eaugouint'] =     quest:message(portSandOriaID.text.PICKPOCKET_EAUGOUINT),
            ['Laucimercen'] =   quest:message(portSandOriaID.text.PICKPOCKET_LAUCIMERCEN),
            ['Marquie'] =       quest:message(portSandOriaID.text.PICKPOCKET_MARQUIE),
            ['Maunadolace'] =   quest:message(portSandOriaID.text.PICKPOCKET_MAUNADOLACE),
            ['Meinemelle'] =    quest:message(portSandOriaID.text.PICKPOCKET_MEINEMELLE):oncePerZone(),
            ['Meuxtajean'] =    quest:message(portSandOriaID.text.PICKPOCKET_MEUXTAJEAN),
            ['Noquerelle'] =    quest:message(portSandOriaID.text.PICKPOCKET_NOQUERELLE),
            ['Parcarin'] =      quest:message(portSandOriaID.text.PICKPOCKET_PARCARIN),
            ['Rielle'] =        quest:message(portSandOriaID.text.PICKPOCKET_RIELLE),
            ['Sheridan'] =      quest:message(portSandOriaID.text.PICKPOCKET_SHERIDAN),
            ['Solgierte'] =     quest:message(portSandOriaID.text.PICKPOCKET_SOLGIERTE),
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Aurege'] =        quest:message(northernSandOriaID.text.PICKPOCKET_AUREGE):importantOnce(),
            ['Gilipese'] =      quest:message(northernSandOriaID.text.PICKPOCKET_GILIPESE),
            ['Guilberdrier'] =  quest:message(northernSandOriaID.text.PICKPOCKET_GUILBERDRIER),
            ['Maurinne'] =      quest:sequence(
                                    { text = northernSandOriaID.text.PICKPOCKET_MAURINNE, wait = 1000 },
                                    { text = northernSandOriaID.text.PICKPOCKET_MAURINNE + 1, face = 82, wait = 2000 },
                                    { face = 115 }
                                ),
            ['Pepigort'] =      quest:message(northernSandOriaID.text.PICKPOCKET_PEPIGORT),
            ['Rodaillece'] =    quest:message(northernSandOriaID.text.PICKPOCKET_RODAILLECE):importantOnce(),
        },

        [xi.zone.WEST_RONFAURE] =
        {
            ['Aaveleon'] =      quest:message(westRonfaureID.text.PICKPOCKET_AAVELEON),
            ['Adalefont'] =     quest:message(westRonfaureID.text.PICKPOCKET_ADALEFONT),
            ['Colmaie'] =       quest:message(westRonfaureID.text.PICKPOCKET_COLMAIE),
            ['Gachemage'] =     quest:message(westRonfaureID.text.PICKPOCKET_GACHEMAGE),
            ['Laillera'] =      quest:message(westRonfaureID.text.PICKPOCKET_LAILLERA),
            ['Palcomondau'] =   quest:message(westRonfaureID.text.PICKPOCKET_PALCOMONDAU),
            ['Zovriace'] =      quest:message(westRonfaureID.text.PICKPOCKET_ZOVRIACE),
        },
    },

    -- After the cutscene ends, speak with Altiret. He asks you to retrieve his wife's glasses for him, since he cannot leave his post.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and vars.Prog == 1
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Miene'] = quest:event(554),
            ['Altiret'] = quest:progressEvent(547),

            onEventFinish =
            {
                [547] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 0)
                end,
            },
        },
    },

    -- Speak to Miene again to get a quest item Eagle Button.
    -- Travel to (F-6) in West Ronfaure. You will find Esca in the tower there.
    -- Speak with her, and she will deny any accusation, demanding proof.
    -- Trade Esca the Eagle Button and she will admit her guilt. She then gives you the Gilt Glasses.
    -- Return to Port San d'Oria and trade the Gilt Glasses to Altiret for your reward.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Altiret'] =
            {
                onTrigger = quest:event(547),

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.item.GILT_GLASSES) then
                        return quest:progressEvent(550)
                    else
                        return quest:event(551)
                    end
                end,
            },

            ['Miene'] =
            {
                onTrigger = function(player, npc)
                    local stage = quest:getVar(player, 'Stage')

                    if stage == 0 then
                        if player:getFreeSlotsCount() > 0 then
                            return quest:progressEvent(549)
                        else
                            return quest:event(552)
                        end
                    else
                        if
                            player:getFreeSlotsCount() > 0 and
                            not player:hasItem(xi.item.EAGLE_BUTTON) and
                            not player:hasItem(xi.item.GILT_GLASSES)
                        then
                            -- Reaquire the button
                            return quest:progressEvent(611)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [549] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.EAGLE_BUTTON) then
                        quest:setVar(player, 'Stage', 1)
                    end
                end,

                [611] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.item.EAGLE_BUTTON)
                end,

                [550] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },

        [xi.zone.WEST_RONFAURE] =
        {
            ['Esca'] =
            {
                onTrigger = function(player, npc, trade)
                    if player:hasItem(xi.item.GILT_GLASSES) then
                        return quest:event(123)
                    else
                        return quest:event(120)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.item.EAGLE_BUTTON) then
                        return quest:progressEvent(121)
                    end
                end,
            },

            onEventFinish =
            {
                [121] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.GILT_GLASSES, { fromTrade = true }) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    -- Section: Completed quest
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Altiret'] = quest:event(580),
        },

        [xi.zone.WEST_RONFAURE] =
        {
            ['Esca'] = quest:event(123),
        },
    },
}

return quest
