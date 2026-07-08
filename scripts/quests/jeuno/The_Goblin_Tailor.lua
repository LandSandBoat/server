-----------------------------------
-- The Goblin Tailor
-----------------------------------
-- Log ID: 3, Quest ID: 42
-- Guttrix : !pos -36.010 4.499 -139.714 245
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_GOBLIN_TAILOR)

local rseTable =
{
    -- [race] = { body, hands, legs, feet }
    [xi.race.HUME_M  ] = { xi.item.CUSTOM_TUNIC,     xi.item.CUSTOM_M_GLOVES,  xi.item.CUSTOM_SLACKS,    xi.item.CUSTOM_M_BOOTS    },
    [xi.race.HUME_F  ] = { xi.item.CUSTOM_VEST,      xi.item.CUSTOM_F_GLOVES,  xi.item.CUSTOM_PANTS,     xi.item.CUSTOM_F_BOOTS    },
    [xi.race.ELVAAN_M] = { xi.item.MAGNA_JERKIN,     xi.item.MAGNA_GAUNTLETS,  xi.item.MAGNA_M_CHAUSSES, xi.item.MAGNA_M_LEDELSENS },
    [xi.race.ELVAAN_F] = { xi.item.MAGNA_BODICE,     xi.item.MAGNA_GLOVES,     xi.item.MAGNA_F_CHAUSSES, xi.item.MAGNA_F_LEDELSENS },
    [xi.race.TARU_M  ] = { xi.item.WONDER_KAFTAN,    xi.item.WONDER_MITTS,     xi.item.WONDER_BRACCAE,   xi.item.WONDER_CLOMPS     },
    [xi.race.TARU_F  ] = { xi.item.WONDER_KAFTAN,    xi.item.WONDER_MITTS,     xi.item.WONDER_BRACCAE,   xi.item.WONDER_CLOMPS     },
    [xi.race.MITHRA  ] = { xi.item.SAVAGE_SEPARATES, xi.item.SAVAGE_GAUNTLETS, xi.item.SAVAGE_LOINCLOTH, xi.item.SAVAGE_GAITERS    },
    [xi.race.GALKA   ] = { xi.item.ELDERS_SURCOAT,   xi.item.ELDERS_BRACERS,   xi.item.ELDERS_BRAGUETTE, xi.item.ELDERS_SANDALS    },
}

local function hasRSE(player)
    local mask = 0
    local rse  = rseTable[player:getRace()]

    for i = 1, #rse do
        if player:hasItem(rse[i]) then
            mask = mask + 2 ^ (i - 1)
        end
    end

    return mask
end

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.JEUNO,
    title    = xi.title.GOBLINS_EXCLUSIVE_FASHION_MANNEQUIN,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Guttrix'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMainLvl() >= 10 and
                        player:getFameLevel(xi.fameArea.JEUNO) >= 3
                    then
                        return quest:progressEvent(10016)
                    else
                        return quest:event(10020)
                    end
                end,
            },

            onEventFinish =
            {
                [10016] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status >= xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.GUSGEN_MINES] =
        {
            ['Treasure_Chest' ] =
            {
                onTrade = function(player, npc, trade)
                    if
                        VanadielRSELocation() == 1 and
                        VanadielRSERace() == player:getRace() and
                        not player:hasKeyItem(xi.keyItem.MAGICAL_PATTERN)
                    then
                        xi.treasure.onTrade(player, npc, trade, 2, xi.keyItem.MAGICAL_PATTERN)

                        return quest:noAction()
                    end
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Guttrix'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() < 10 then
                        return quest:event(10020)
                    end

                    local rseGear = hasRSE(player)
                    if rseGear >= 15 then
                        return quest:event(10019)
                    end

                    if player:hasKeyItem(xi.ki.MAGICAL_PATTERN) then
                        return quest:progressEvent(10018, rseGear)
                    else
                        return quest:event(10017, VanadielRSELocation(), VanadielRSERace())
                    end
                end,
            },

            onEventFinish =
            {
                [10018] = function(player, csid, option, npc)
                    if
                        option >= 1 and
                        option <= 4 and
                        player:hasKeyItem(xi.keyItem.MAGICAL_PATTERN)
                    then
                        if npcUtil.giveItem(player, rseTable[player:getRace()][option]) then
                            player:delKeyItem(xi.keyItem.MAGICAL_PATTERN)

                            if player:getQuestStatus(quest.areaId, quest.questId) == xi.questStatus.QUEST_ACCEPTED then
                                quest:complete(player)
                            end
                        end
                    end
                end,
            },
        },

        [xi.zone.MAZE_OF_SHAKHRAMI] =
        {
            ['Treasure_Chest' ] =
            {
                onTrade = function(player, npc, trade)
                    if
                        VanadielRSELocation() == 2 and
                        VanadielRSERace() == player:getRace() and
                        not player:hasKeyItem(xi.keyItem.MAGICAL_PATTERN)
                    then
                        xi.treasure.onTrade(player, npc, trade, 2, xi.keyItem.MAGICAL_PATTERN)

                        return quest:noAction()
                    end
                end,
            },
        },

        [xi.zone.ORDELLES_CAVES] =
        {
            ['Treasure_Chest' ] =
            {
                onTrade = function(player, npc, trade)
                    if
                        VanadielRSELocation() == 0 and
                        VanadielRSERace() == player:getRace() and
                        not player:hasKeyItem(xi.keyItem.MAGICAL_PATTERN)
                    then
                        xi.treasure.onTrade(player, npc, trade, 2, xi.keyItem.MAGICAL_PATTERN)

                        return quest:noAction()
                    end
                end,
            },
        },
    },
}

return quest
