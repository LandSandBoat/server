-----------------------------------
-- Dormant Powers Dislodged
-----------------------------------
-- Log ID: 3, Quest ID: 136
-- Nomad Moogle : !pos 10.012 1.453 121.883 243
-----------------------------------
local ruludeID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.DORMANT_POWERS_DISLODGED)

-- NOTE: Timing minigame was guesstimated! No capture available.
-- The event seems to handle the actual timing. As in, it counts for us.
-- Always the same camera angle at victory. That is, close up of player, at arround 9 seconds.
-- Wining timing: 10 seconds aprox.

local itemWantedTable =
{
    [0] = { xi.item.PINCH_OF_VALKURM_SUNSAND },
    [1] = { xi.item.FADED_CRYSTAL            },
    [2] = { xi.item.ORCISH_PLATE_ARMOR       },
    [3] = { xi.item.MAGICKED_SKULL           },
    [4] = { xi.item.CUP_OF_DHALMEL_SALIVA    },
    [5] = { xi.item.YAGUDO_CAULK             },
    [6] = { xi.item.SIRENS_TEAR              },
    [7] = { xi.item.DANGRUF_STONE            },
    [8] = { xi.item.ORCISH_AXE               },
    [9] = { xi.item.QUADAV_BACKSCALE         },
    -- 10+ = It repeats the pattern ad nauseam.
}

quest.reward =
{
    fame     = 50,
    fameArea = xi.fameArea.JEUNO,
    keyItem  = xi.ki.SOUL_GEM,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.BEYOND_THE_STARS) and
                player:getLevelCap() == 90
        end,

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrigger = function(player, npc)
                    local playerLevel     = player:getMainLvl()
                    local limitBreaker    = player:hasKeyItem(xi.ki.LIMIT_BREAKER) and 1 or 2
                    local lastQuestNumber = 0
                    local lastQuestStage  = 0
                    local option          = quest:getVar(player, 'Option') -- Has rejected signing the contract?
                    local itemChosen      = quest:getVar(player, 'itemWanted') - 1
                    if
                        xi.settings.main.MAX_LEVEL > 90 and
                        limitBreaker == 1
                    then
                        if playerLevel > 85 then
                            lastQuestNumber = 4
                        elseif playerLevel >= 75 then
                            lastQuestNumber = 3
                            lastQuestStage  = 2
                        end
                    end

                    -- Save item Chosen
                    if itemChosen < 0 then
                        itemChosen = math.random(0, 9)
                        quest:setVar(player, 'itemWanted', itemChosen + 1)
                    end

                    return quest:progressEvent(10045, playerLevel, limitBreaker, lastQuestNumber, lastQuestStage, option, itemChosen)
                end,
            },

            onEventUpdate =
            {
                [10045] = function(player, csid, option, npc)
                    -- This event update checks if you have completed "Beat Around the Bushin" quest. If so, Atori-Tutori recognizes you.
                    if option == 8 then
                        local knowAtori = player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.BEAT_AROUND_THE_BUSHIN) and 1 or 0
                        player:updateEvent(knowAtori)
                    end
                end,
            },

            onEventFinish =
            {
                [10045] = function(player, csid, option, npc)
                    -- Accept quest option.
                    if option == 11 then
                        quest:begin(player)

                    -- Reject signing. Quest not added to log.
                    elseif option == 12 then
                        quest:setVar(player, 'Option', 1)
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

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Nomad_Moogle'] =
            {
                onTrade = function(player, npc, trade)
                    local itemWanted  = quest:getVar(player, 'itemWanted') - 1
                    local itemToTrade = itemWantedTable[itemWanted][1]

                    if
                        npcUtil.tradeHasExactly(trade, { { xi.item.KINDREDS_CREST, 1 }, { itemToTrade, 1 } }) and
                        player:getMeritCount() > 9
                    then
                        return quest:progressEvent(10191)
                    end
                end,

                onTrigger = function(player, npc)
                    local playerLevel = player:getMainLvl()

                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(10192, playerLevel, 0, 0, 2) -- Timing Minigame starting event.
                    else
                        local limitBreaker    = player:hasKeyItem(xi.ki.LIMIT_BREAKER) and 1 or 2
                        local lastQuestNumber = 4
                        local lastQuestStage  = 1
                        local itemChosen      = quest:getVar(player, 'itemWanted')
                        return quest:event(10045, playerLevel, limitBreaker, lastQuestNumber, lastQuestStage, 0, itemChosen)
                    end
                end,
            },

            onEventUpdate =
            {
                [10192] = function(player, csid, option, npc)
                    -- Option: Push! The option is the number of frames. 1 sec = 60 frames. Probably.
                    if option >= 780 then
                        player:updateEvent(4) -- Over 13 seconds. Slime.
                    elseif option >= 660 then
                        player:updateEvent(3) -- Between 11 and 13 seconds.Big Egg.
                    elseif option >= 540 then
                        player:updateEvent(2) -- Between 9 and 11 seconds. Glowing Egg. Win!
                    elseif option >= 420 then
                        player:updateEvent(1) -- Between 7 and 9 seconds. Regular Egg.
                    else
                        player:updateEvent(0) -- Under 7 seconds. Mandragora.
                    end
                end,
            },

            onEventFinish =
            {
                [10191] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:setMerits(player:getMeritCount() - 10)
                    quest:setVar(player, 'Prog', 1)
                end,

                [10192] = function(player, csid, option, npc)
                    if
                        option >= 540 and
                        option < 660
                    then
                        quest:complete(player)
                        player:setLevelCap(95)
                        player:messageSpecial(ruludeID.text.YOUR_LEVEL_LIMIT_IS_NOW_95)
                    end
                end,
            },
        },
    },
}

return quest
