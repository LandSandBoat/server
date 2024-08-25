-----------------------------------
-- Mihgo's Amigo
-----------------------------------
-- Log ID: 2, Quest ID: 25
-- Nanaa Mihgo       : !pos 62 -4 240 241
-- Cha Lebagta       : !pos 58 -6 216 241
-- Bopa Greso        : !pos 59 -6 216 241
-- Mheca Khetashipah : !pos 66 -6 185 241
-- Gioh Ajihri       : !pos 108 -5 176 241
-- Wani Casdohry     : !pos 104 -5 176 241
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.MIHGO_S_AMIGO)

local gilPerTrade = 200

quest.reward =
{
    fame     = 60, -- 16 era based on 212 Yagudo Necklaces for 4 Norg fame
    fameArea = xi.fameArea.NORG,
    title    = xi.title.CAT_BURGLAR_GROUPIE,
}

quest.sections =
{
    {
        -- QUEST AVAILABLE
        check = function(player, status, vars)
            local lostForWords = player:getMissionStatus(xi.mission.log_id.WINDURST, xi.mission.id.windurst.LOST_FOR_WORDS)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.NORG) >= 1 and
                player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN) ~= xi.questStatus.QUEST_ACCEPTED and
                player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.AS_THICK_AS_THIEVES) ~= xi.questStatus.QUEST_ACCEPTED and
                lostForWords == 0 and -- Player cannot accept quest during Lost For Words Mission
                not player:hasItem(xi.item.MARAUDERS_KNIFE)
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Nanaa_Mihgo'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS) == xi.questStatus.QUEST_ACCEPTED then
                        return quest:progressEvent(81) -- come to apologize
                    else
                        return quest:progressEvent(80)
                    end
                end,
            },

            onEventFinish =
            {
                [80] = function(player, csid, option, npc)
                    return quest:begin(player)
                end,

                [81] = function(player, csid, option, npc)
                    quest:setVar(player, 'CryingforOnions', 1)
                    return quest:begin(player)
                end,
            },
        },
    },

    {
        -- QUEST ACCEPTED
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Bopa_Greso'] = quest:event(84, 0, xi.item.YAGUDO_BEAD_NECKLACE), -- Migho's Amigo hint dialog

            ['Cha_Lebagta'] = quest:event(85, 0, xi.item.YAGUDO_BEAD_NECKLACE), -- Migho's Amigo hint dialog

            ['Gioh_Ajihri'] = quest:event(87),

            ['Mheca_Khetashipah'] = quest:event(83),

            ['Nanaa_Mihgo'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.YAGUDO_BEAD_NECKLACE, 4 } }) then
                        if quest:getVar(player, 'CryingforOnions') == 1 then
                            return quest:progressEvent(92, { [0] = xi.settings.main.GIL_RATE * gilPerTrade }) -- apology accepted
                        else
                            return quest:progressEvent(88, { [0] = xi.settings.main.GIL_RATE * gilPerTrade })
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(82)
                end,
            },

            ['Wani_Casdohry'] = quest:event(86, 0, xi.item.YAGUDO_BEAD_NECKLACE), -- Migho's Amigo hint dialog

            onEventFinish =
            {
                [88] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:addGil(xi.settings.main.GIL_RATE * gilPerTrade)
                        xi.quest.setMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER)
                    end
                end,
            },
        },
    },

    -- QUEST COMPLETE
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WOODS] =
        {

            ['Bopa_Greso'] = quest:event(90, 0, xi.item.YAGUDO_BEAD_NECKLACE), -- New standard dialog after Mihgo's Amigo completion
            ['Cha_Lebagta'] = quest:event(91, 0, xi.item.YAGUDO_BEAD_NECKLACE), -- New standard dialog after Mihgo's Amigo completion

            ['Nanaa_Mihgo'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.YAGUDO_BEAD_NECKLACE, 4 } }) then
                        return quest:progressEvent(494, { [0] = xi.settings.main.GIL_RATE * gilPerTrade })
                    end
                end,

                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER) < xi.questStatus.QUEST_ACCEPTED then
                        return quest:event(89):replaceDefault()
                    end
                end,
            },

            onEventFinish =
            {
                [494] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:addGil(xi.settings.main.GIL_RATE * gilPerTrade)
                    player:addFame(xi.fameArea.NORG, 30) -- 16 era based on 212 Yagudo Necklaces for 4 Norg fame
                end,
            },
        },
    },
}

return quest
