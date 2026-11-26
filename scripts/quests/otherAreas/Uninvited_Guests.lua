-----------------------------------
-- Uninvited Guests
-----------------------------------
-- Log ID: 4, Quest ID: 81
-- Justinius    : !pos 76 -34 68
-- Monarch Linn : !zone 31
-----------------------------------

-- TODO: Add ROE rewards

local phase =
{
    WAITING_IN_VICTORY   = 0,
    GO_TO_MONARCH_LINN   = 1,
    RETURNING_IN_VICTORY = 2,
    RETURNING_IN_DEFEAT  = 3,
    WAITING_IN_DEFEAT    = 4,
}

local var =
{
    QUEST_REWARD  = 'UninvitedGuestsReward',
    PROGRESS      = 'Prog',
    CONQUEST_WAIT = 'Wait'
}

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.UNINVITED_GUESTS)

-- The reward is one item, rolled when the player reports in. Weights total 1000.
-- The item list comes from the JP wiki. Retail rates are not published.
-- The memoirs is the common result. The breastplate is the rarest.
--
-- Source: https://wiki.ffo.jp/html/3837.html
local rewards =
{
    { dropWeight = 541, rewardID = xi.item.MIRATETES_MEMOIRS           },

    -- Common.
    { dropWeight =  25, rewardID = xi.item.PLATE_OF_BREAM_RISOTTO      },
    { dropWeight =  25, rewardID = xi.item.SQUARE_OF_RAXA              },
    { dropWeight =  25, rewardID = xi.item.CHUNK_OF_ALUMINUM_ORE       },
    { dropWeight =  25, rewardID = xi.item.SERVING_OF_CRIMSON_JELLY    },
    { dropWeight =  25, rewardID = xi.item.TAVNAZIAN_SALAD             },
    { dropWeight =  25, rewardID = xi.item.SERVING_OF_BISON_STEAK      },
    { dropWeight =  25, rewardID = xi.item.BOWL_OF_MUSHROOM_STEW       },
    { dropWeight =  25, rewardID = xi.item.TIGER_EYE                   },
    { dropWeight =  25, rewardID = xi.item.UNICORN_HORN                },
    { dropWeight =  25, rewardID = xi.item.ARMOIRE                     },
    { dropWeight =  25, rewardID = xi.item.MANNEQUIN_BODY              },
    { dropWeight =  25, rewardID = xi.item.PLATE_OF_MUSHROOM_RISOTTO   },

    -- Less common.
    { dropWeight =  14, rewardID = xi.item.MANNEQUIN_HANDS             },
    { dropWeight =  14, rewardID = xi.item.OVERSIZED_FANG              },
    { dropWeight =  14, rewardID = xi.item.DRAGON_BONE                 },
    { dropWeight =  14, rewardID = xi.item.ELM_LOG                     },
    { dropWeight =  14, rewardID = xi.item.MANNEQUIN_LEGS              },
    { dropWeight =  14, rewardID = xi.item.MANNEQUIN_FEET              },
    { dropWeight =  14, rewardID = xi.item.CHUNK_OF_ADAMAN_ORE         },

    -- Uncommon.
    { dropWeight =   7, rewardID = xi.item.BEHEMOTH_HIDE               },
    { dropWeight =   7, rewardID = xi.item.PIECE_OF_HABU_SKIN          },
    { dropWeight =   7, rewardID = xi.item.CLOUD_EVOKER                },
    { dropWeight =   7, rewardID = xi.item.MANNEQUIN_HEAD              },
    { dropWeight =   7, rewardID = xi.item.CHUNK_OF_ORICHALCUM_ORE     },
    { dropWeight =   7, rewardID = xi.item.SERVING_OF_VERMILLION_JELLY },

    -- Rare.
    { dropWeight =   2, rewardID = xi.item.LEREMIEU_SALAD              },
    { dropWeight =   2, rewardID = xi.item.ADAMANTOISE_SHELL           },
    { dropWeight =   2, rewardID = xi.item.PIECE_OF_ANGEL_SKIN         },
    { dropWeight =   2, rewardID = xi.item.DRAGON_HEART                },
    { dropWeight =   2, rewardID = xi.item.SERVING_OF_MARBLED_STEAK    },
    { dropWeight =   2, rewardID = xi.item.PLATE_OF_SEA_SPRAY_RISOTTO  },
    { dropWeight =   2, rewardID = xi.item.LOCK_OF_SIRENS_HAIR         },
    { dropWeight =   2, rewardID = xi.item.PLATE_OF_WITCH_RISOTTO      },
    { dropWeight =   2, rewardID = xi.item.BOWL_OF_WITCH_STEW          },

    -- Rarest.
    { dropWeight =   1, rewardID = xi.item.ASSAULT_BREASTPLATE         },
}

-----------------------------------
-- Set quest in starting state.
-----------------------------------
local startQuest = function(player)
    npcUtil.giveKeyItem(player, xi.keyItem.MONARCH_LINN_PATROL_PERMIT)
    quest:setVar(player, var.PROGRESS, phase.GO_TO_MONARCH_LINN)
    player:setCharVar(var.QUEST_REWARD, 0)
    quest:begin(player)
end

-----------------------------------
-- A player variable is used to prevent the holding of Rare/Ex item to force a recalculation.
-----------------------------------
local generateReward = function(player)
    local totalChance = 0
    local rewardID    = 0

    for _, item in pairs(rewards) do
        totalChance = totalChance + item.dropWeight
    end

    local roll = math.randomInt(1, totalChance)

    for _, item in pairs(rewards) do
        totalChance = totalChance - item.dropWeight

        if roll > totalChance then
            rewardID = item.rewardID
            break
        end
    end

    player:setCharVar(var.QUEST_REWARD, rewardID)

    return rewardID
end

-----------------------------------
-- Give item (or gil) reward to player.
-----------------------------------
local giveReward = function(player)
    local rewardID = player:getCharVar(var.QUEST_REWARD)

    if rewardID == 0 then
        rewardID = generateReward(player)
    end

    -- Retail does not complete the quest when the reward cannot be handed over.
    -- The player keeps the rolled reward and reports again after making room.
    if not npcUtil.giveItem(player, rewardID) then
        return
    end

    -- The first clear pays 10,000 gil on top of the item per JP wiki.
    if not player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.UNINVITED_GUESTS) then
        npcUtil.giveCurrency(player, 'gil', 10000)
    end

    if quest:complete(player) then
        player:delCurrentQuest(quest.areaId, quest.questId)
        quest:setVar(player, var.CONQUEST_WAIT, NextConquestTally())
        player:setCharVar(var.QUEST_REWARD, 0)
    end
end

quest.reward =
{
    title = xi.title.MONARCH_LINN_PATROL_GUARD,
}

local justinius =
{
    ['Justinius'] =
    {
        onTrigger = function(player, npc)
            local questProgress        = quest:getVar(player, var.PROGRESS)
            local conquestWaitFinished = quest:getVar(player, var.CONQUEST_WAIT) < NextConquestTally()

            if questProgress == phase.WAITING_IN_VICTORY then
                local completed = player:hasCompletedQuest(quest.areaId, quest.questId)

                -- Recover an accepted patrol whose progress variable is missing.
                if
                    not completed and
                    player:hasKeyItem(xi.keyItem.MONARCH_LINN_PATROL_PERMIT)
                then
                    quest:setVar(player, var.PROGRESS, phase.GO_TO_MONARCH_LINN)
                    return quest:event(571)
                elseif not conquestWaitFinished then
                    return
                elseif completed then
                    return quest:progressEvent(573)
                end

                return quest:progressEvent(570)
            end

            -- Player tried the battle and either lost or warped out.
            if
                questProgress == phase.GO_TO_MONARCH_LINN and
                not player:hasKeyItem(xi.keyItem.MONARCH_LINN_PATROL_PERMIT)
            then
                questProgress = phase.RETURNING_IN_DEFEAT
                quest:setVar(player, var.PROGRESS, questProgress)
            end

            -- Go to Monarch Linn.
            if questProgress == phase.GO_TO_MONARCH_LINN then
                return quest:event(571)

            -- Victory. Give reward.
            elseif questProgress == phase.RETURNING_IN_VICTORY then
                return quest:progressEvent(572)

            -- Reissue key item after failure. Player has waited for conquest tally.
            elseif
                questProgress == phase.WAITING_IN_DEFEAT and
                conquestWaitFinished
            then
                return quest:progressEvent(574)

            -- Report the defeat and start the wait.
            elseif questProgress == phase.RETURNING_IN_DEFEAT then
                return quest:progressEvent(575)

            -- Remind the player to wait for the next tally.
            elseif questProgress == phase.WAITING_IN_DEFEAT then
                return quest:event(575)
            end
        end,
    },

    onEventFinish =
    {
        [570] = function(player, csid, option, npc)
            if
                option == 1 and
                player:getQuestStatus(quest.areaId, quest.questId) == xi.questStatus.QUEST_ACCEPTED and
                quest:getVar(player, var.PROGRESS) == phase.WAITING_IN_VICTORY and
                quest:getVar(player, var.CONQUEST_WAIT) < NextConquestTally() and
                not player:hasKeyItem(xi.keyItem.MONARCH_LINN_PATROL_PERMIT)
            then
                startQuest(player)
            end
        end,

        -- Victory; Wait gets set with Reward.
        [572] = function(player, csid, option, npc)
            if
                option == 0 and
                quest:getVar(player, var.PROGRESS) == phase.RETURNING_IN_VICTORY
            then
                giveReward(player)
            end
        end,

        -- Repeat quest
        [573] = function(player, csid, option, npc)
            if
                option == 1 and
                player:hasCompletedQuest(quest.areaId, quest.questId) and
                quest:getVar(player, var.PROGRESS) == phase.WAITING_IN_VICTORY and
                quest:getVar(player, var.CONQUEST_WAIT) < NextConquestTally()
            then
                startQuest(player)
            end
        end,

        -- Repeat quest after failure (and waiting until next conquest).
        [574] = function(player, csid, option, npc)
            if
                quest:getVar(player, var.PROGRESS) == phase.WAITING_IN_DEFEAT and
                quest:getVar(player, var.CONQUEST_WAIT) < NextConquestTally()
            then
                startQuest(player)
            end
        end,

        -- Player has failed and must wait until conquest to retry.
        [575] = function(player, csid, option, npc)
            if quest:getVar(player, var.PROGRESS) == phase.RETURNING_IN_DEFEAT then
                quest:setVar(player, var.CONQUEST_WAIT, NextConquestTally())
                quest:setVar(player, var.PROGRESS, phase.WAITING_IN_DEFEAT)
            end
        end,
    },
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SAVAGE)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Justinius'] = quest:progressEvent(570),

            onEventFinish =
            {
                [570] = function(player, csid, option, npc)
                    if option == 1 then
                        startQuest(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] = justinius,
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] = justinius,
    },
}

return quest
