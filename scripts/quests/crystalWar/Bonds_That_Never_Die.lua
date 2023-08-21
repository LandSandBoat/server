-----------------------------------
-- Bonds That Never Die
-----------------------------------
-- !addquest 7 45
-- Rholont : !pos -168 -2 56 80
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BONDS_THAT_NEVER_DIE)

quest.reward =
{
    item = xi.item.BEHEMOTH_HORN,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_PRICE_OF_VALOR)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rholont'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.LETTER_TO_COUNT_AURCHIAT) then
                        return quest:progressEvent(649)
                    else
                        return quest:event(651)
                    end
                end,
            },

            onEventFinish =
            {
                [649] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_TO_COUNT_AURCHIAT)
                end,
            },
        },

        [xi.zone.PASHHOW_MARSHLANDS_S] =
        {
            ['Shimmering_Pondweed'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.LETTER_TO_COUNT_AURCHIAT) then
                        return quest:progressEvent(107)
                    end
                end,
            },

            onEventFinish =
            {
                [107] = function(player, csid, option, npc)
                    quest:begin(player)
                    player:delKeyItem(xi.ki.LETTER_TO_COUNT_AURCHIAT)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['Overgrown_Mushrooms'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(212)
                    elseif
                        questProgress == 1 and
                        player:hasKeyItem(xi.ki.LENGTH_OF_JUGNER_IVY)
                    then
                        return quest:progressEvent(213)
                    end
                end,
            },

            ['Mossy_Stump'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(214)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if quest:getVar(player, 'Prog') == 4 then
                        return 215
                    end
                end,
            },

            onEventFinish =
            {
                [212] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.HATCHET) then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [213] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [214] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [215] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },

        [xi.zone.EVERBLOOM_HOLLOW] =
        {
            onEventFinish =
            {
                [10000] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                    player:setPos(-285.717, 0.5, 88.107, 98, xi.zone.JUGNER_FOREST_S)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rongelouts_N_Distaud'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(650)
                    end
                end,
            },

            ['Rholont'] = quest:event(651),

            onEventFinish =
            {
                [650] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setVar(player, 'Option', 1)

                        xi.quest.setVar(player, xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SONGBIRDS_IN_A_SNOWSTORM, 'Timer', VanadielUniqueDay() + 1)
                        xi.quest.setMustZone(player, xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SONGBIRDS_IN_A_SNOWSTORM)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rongelouts_N_Distaud'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 1 then
                        return quest:progressEvent(654)
                    end
                end,
            },

            onEventFinish =
            {
                [654] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 0)
                end,
            },
        },
    },
}

return quest
