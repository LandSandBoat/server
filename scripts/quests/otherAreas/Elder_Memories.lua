-----------------------------------
-- Elder Memories
-----------------------------------
-- Log ID: 4, Quest ID: 24
-- !addquest 4 24
-- Isacio : !pos -54 -1 -44 248
-----------------------------------
-- Mutually exclusive with The Old Lady. Cannot be started if The Old Lady has been started or completed.
-----------------------------------
local selbinaID = zones[xi.zone.SELBINA]
-----------------------------------

local subJobItems =
{
    [0] = { item = xi.item.MAGICKED_SKULL, tradeEvent = 115 },
    [1] = { item = xi.item.DAMSELFLY_WORM, tradeEvent = 116 },
    [2] = { item = xi.item.CRAB_APRON,     tradeEvent = 117 },
}

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.ELDER_MEMORIES)

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_OLD_LADY) == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.SELBINA] =
        {
            ['Isacio'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() >= xi.settings.main.SUBJOB_QUEST_LEVEL then
                        return quest:progressEvent(111, xi.item.MAGICKED_SKULL) -- Player is eligible for the quest.
                    else
                        return quest:event(119) -- Player level is too low to be offered the quest.
                    end
                end,
            },

            onEventFinish =
            {
                [111] = function(player, csid, option, npc)
                    if option == 40 then -- Accepted quest.
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Vera'] = quest:event(130):replaceDefault(),
        },

        [xi.zone.SELBINA] =
        {
            ['Isacio'] =
            {
                onTrade = function(player, npc, trade)
                    local questProgress = quest:getVar(player, 'Prog')
                    local step          = subJobItems[questProgress]

                    if step and npcUtil.tradeMatches(trade, { { step.item, 1 } }) then
                        local nextStep = subJobItems[questProgress + 1]

                        if nextStep then
                            return quest:progressEvent(step.tradeEvent, nextStep.item)
                        else
                            return quest:progressEvent(step.tradeEvent)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    -- Obtained from Rhapsodies of Vanadiel 1-4, allows player to skip the item collection.
                    if player:hasKeyItem(xi.ki.GILGAMESHS_INTRODUCTORY_LETTER) then
                        return quest:progressEvent(117)
                    end

                    local step = subJobItems[quest:getVar(player, 'Prog')]
                    if step then
                        return quest:event(114, step.item)
                    end
                end,
            },

            onEventFinish =
            {
                [115] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 1)
                end,

                [116] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 2)
                end,

                [117] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        player:unlockJob(0)
                        player:messageSpecial(selbinaID.text.SUBJOB_UNLOCKED)
                    end
                end,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Vera'] = quest:event(130):replaceDefault(),
        },

        [xi.zone.SELBINA] =
        {
            ['Isacio'] = quest:event(118):replaceDefault(),
        },
    },
}

return quest
