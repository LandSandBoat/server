-----------------------------------
-- Blast from the Past
-----------------------------------
-- Log ID: 2, Quest ID: 11
-- Koru-Moru : !pos -120 -6 124 239
-----------------------------------
local shakhramiID = zones[xi.zone.MAZE_OF_SHAKHRAMI]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.BLAST_FROM_THE_PAST)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.WINDURST,
    item     = xi.item.GREAT_CLUB,
    title    = xi.title.FOSSILIZED_SEA_FARER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.STAR_STRUCK) and
                player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CLASS_REUNION) ~= xi.questStatus.QUEST_ACCEPTED and
                player:getFameLevel(xi.fameArea.WINDURST) >= 3 and
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
                        quest:setVar(player, 'option', 215)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.item.BURNITE_SHELL_STONE) then
                        return quest:progressEvent(224)
                    else
                        return quest:event(225)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(quest:getVar(player, 'option')) -- Koru-Moru alternates between 2 dialogs until turn in
                end,
            },

            ['Yoran-Oran'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(221):importantOnce() -- optional dialogue until turn in
                end,
            },

            ['Bonchacha'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(218):importantOnce() -- optional dialogue until turn in
                end
            },

            ['Maan-Pokuun'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(220):importantOnce() -- optional dialogue until turn in
                end
            },

            onEventFinish =
            {
                [215] = function(player, csid, option, npc)
                    quest:setVar(player, 'option', 216)
                end,

                [216] = function(player, csid, option, npc)
                    quest:setVar(player, 'option', 215)
                end,

                [224] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()

                        xi.quest.setMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.NOTHING_MATTERS)
                    end
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Tokaka'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(318):importantOnce() -- optional dialogue until turn in
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
            return status == xi.questStatus.QUEST_COMPLETED and
                xi.quest.getMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.NOTHING_MATTERS)
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru']  = quest:event(226):importantEvent(),
            ['Yoran-Oran'] = quest:event(222):importantEvent(),
        },
    },
}

return quest
