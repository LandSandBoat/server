-----------------------------------
-- Blast from the Past
-----------------------------------
-- Log ID: 2, Quest ID: 11
-- Koru-Moru : !pos -120 -6 124 239
-----------------------------------
local shakhramiID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLAST_FROM_THE_PAST)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.WINDURST,
    item     = xi.item.GREAT_CLUB,
    title    = xi.title.FOSSILIZED_SEA_FARER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.STAR_STRUCK) and
                player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CLASS_REUNION) ~= QUEST_ACCEPTED and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 3 and
                not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru'] = quest:progressEvent(214),

            onEventFinish =
            {
                [214] = function(player, csid, option, npc)
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

        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.BURNITE_SHELL_STONE) then
                        return quest:progressEvent(224)
                    else
                        return quest:event(225)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 2 then
                        return quest:event(215)
                    else
                        return quest:event(216)
                    end
                end,
            },

            ['Yoran-Oran'] =
            {
                onTrigger = function(player, npc)
                    local questOption = quest:getVar(player, 'Option')

                    if questOption == 1 then
                        return quest:progressEvent(221)
                    elseif questOption == 2 then
                        return quest:event(222):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [221] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 2)
                end,

                [224] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()

                        xi.quest.setMustZone(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.NOTHING_MATTERS)
                    end
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Tokaka'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 0 then
                        return quest:progressEvent(318)
                    end
                end,
            },

            onEventFinish =
            {
                [318] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,
            },
        },

        [xi.zone.MAZE_OF_SHAKHRAMI] =
        {
            ['Fossil_Rock'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Break out Fossil Rock into multiple NPC names and update impacted
                    -- quests and missions.
                    local rockOffset = npc:getID() - shakhramiID.npc.FOSSIL_ROCK_OFFSET

                    if rockOffset == 8 then
                        if
                            not GetMobByID(shakhramiID.mob.ICHOROUS_IRE):isSpawned() and
                            not player:hasItem(xi.item.BURNITE_SHELL_STONE)
                        then
                            SpawnMob(shakhramiID.mob.ICHOROUS_IRE):updateClaim(player)
                        else
                            player:messageSpecial(shakhramiID.text.FOSSIL_EXTRACTED + 2)
                        end
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                not xi.quest.getMustZone(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.NOTHING_MATTERS)
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Yoran-Oran'] = quest:event(223):importantEvent(),
        },
    },
}

return quest
