-----------------------------------
-- The Old Lady
-----------------------------------
-- Log ID: 4, Quest ID: 10
-- !addquest 4 10
-- Vera : !pos -49 -5 20 249
-----------------------------------
-- Mutually exclusive with Elder Memories. Cannot be started if Elder Memories has been started or completed.
-----------------------------------
local mhauraID = zones[xi.zone.MHAURA]
-----------------------------------

local subJobItems =
{
    [0] = { item = xi.item.WILD_RABBIT_TAIL,      tradeEvent = 135 },
    [1] = { item = xi.item.CUP_OF_DHALMEL_SALIVA, tradeEvent = 136 },
    [2] = { item = xi.item.BLOODY_ROBE,           tradeEvent = 137 },
}

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.THE_OLD_LADY)

quest.sections =
{
    -- Section: Quest is available
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.ELDER_MEMORIES) == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.MHAURA] =
        {
            ['Vera'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() >= xi.settings.main.SUBJOB_QUEST_LEVEL then
                        return quest:progressEvent(131, xi.item.WILD_RABBIT_TAIL) -- Player is eligible for the quest.
                    else
                        return quest:event(133) -- Player level is too low to be offered the quest.
                    end
                end,
            },

            onEventFinish =
            {
                [131] = function(player, csid, option, npc)
                    if option == 40 then -- Accepted quest.
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.MHAURA] =
        {
            ['Vera'] =
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
                        return quest:progressEvent(137)
                    end

                    local step = subJobItems[quest:getVar(player, 'Prog')]
                    if step then
                        return quest:event(132, step.item)
                    end
                end,
            },

            onEventFinish =
            {
                [135] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 1)
                end,

                [136] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 2)
                end,

                [137] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        player:unlockJob(0)
                        player:messageSpecial(mhauraID.text.SUBJOB_UNLOCKED)
                    end
                end,
            },
        },

        [xi.zone.SELBINA] =
        {
            ['Isacio'] = quest:event(99):replaceDefault(),
        },
    },

    -- Section: Quest completed
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.MHAURA] =
        {
            ['Vera'] = quest:event(138):replaceDefault(),
        },

        [xi.zone.SELBINA] =
        {
            ['Isacio'] = quest:event(99):replaceDefault(),
        },
    },
}

return quest
