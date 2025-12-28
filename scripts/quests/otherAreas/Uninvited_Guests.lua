-----------------------------------
-- Uninvited Guests
-----------------------------------
-- Log ID: 4, Quest ID: 81
-- Justinius    : !pos 76 -34 68
-- Monarch Linn : !zone 31
-----------------------------------

-- TODO: Implement full rewards
-- TODO: Add ROE rewards

local phase =
{
    WAITING_IN_VICTORY   = 0,
    GO_TO_MONARCH_LINN   = 1,
    RETURNING_IN_VICTORY = 2,
    RETURNING_IN_DEFEAT  = 3,
    WAITING_IN_DEFEAT    = 4,
}

local defeatedWaitingMessages =
{
    135,    -- Idle chatter.
    575,    -- Defeated and waiting.
}

local var =
{
    QUEST_REWARD   = 'UninvitedGuestsReward',
    PROGRESS       = 'Prog',
    CONQUEST_WAIT  = 'Wait',
    DEFEAT_MESSAGE = 'UninvitedGuestsDefeatMessage'
}

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.UNINVITED_GUESTS)

local rewards =
{
    { dropWeight = 100, rewardID = xi.item.MIRATETES_MEMOIRS },
}

-----------------------------------
-- Set quest in starting state.
-----------------------------------
local startQuest = function(player)
    npcUtil.giveKeyItem(player, xi.ki.MONARCH_LINN_PATROL_PERMIT)
    quest:setVar(player, var.PROGRESS, phase.GO_TO_MONARCH_LINN)
    player:setCharVar(var.DEFEAT_MESSAGE, 0)
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

    local roll = math.random(totalChance)

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

    if rewardID == xi.item.GIL and quest:complete(player) then
        if npcUtil.giveCurrency(player, 'gil', 10000) then
            quest:setVar(player, var.CONQUEST_WAIT, NextConquestTally())
            player:setCharVar(var.QUEST_REWARD, 0)
        end
    elseif quest:complete(player) then
        if npcUtil.giveItem(player, rewardID) then
            quest:setVar(player, var.CONQUEST_WAIT, NextConquestTally())
            player:setCharVar(var.QUEST_REWARD, 0)
        end
    end
end

quest.reward =
{
    title = xi.title.MONARCH_LINN_PATROL_GUARD,
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
            return (status == xi.questStatus.QUEST_ACCEPTED) or (status == xi.questStatus.QUEST_COMPLETED)
        end,

        [xi.zone.MONARCH_LINN] =
        {
            -- Battlefield Win
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    quest:setVar(player, var.PROGRESS, phase.RETURNING_IN_VICTORY)
                end,
            },
        },

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Justinius'] =
            {
                onTrigger = function(player, npc)
                    local questProgress        = quest:getVar(player, var.PROGRESS)
                    local conquestWaitFinished = quest:getVar(player, var.CONQUEST_WAIT) < NextConquestTally()
                    local rewardID             = player:getCharVar(var.QUEST_REWARD)

                    -- Player tried the battle and either lost or warped out.
                    if
                        questProgress == 1 and
                        not player:hasKeyItem(xi.ki.MONARCH_LINN_PATROL_PERMIT)
                    then
                        questProgress = phase.RETURNING_IN_DEFEAT
                        quest:setVar(player, var.PROGRESS, questProgress)
                    end

                    -- Go to Monarch Linn.
                    if questProgress == phase.GO_TO_MONARCH_LINN then
                        return quest:progressEvent(571)

                    -- Victory. Give reward.
                    elseif
                        questProgress == phase.RETURNING_IN_VICTORY or
                        rewardID > 0
                    then
                        return quest:progressEvent(572)

                    -- Reissue key item after victory. Player has waited for conquest tally.
                    elseif
                        questProgress == phase.WAITING_IN_VICTORY and
                        conquestWaitFinished
                    then
                        return quest:progressEvent(573)

                    -- Reissue key item after failure. Player has waited for conquest tally.
                    elseif
                        questProgress == phase.WAITING_IN_DEFEAT and
                        conquestWaitFinished
                    then
                        return quest:progressEvent(574)

                    -- Failure. Player must wait until next conquest tally.
                    elseif questProgress == phase.RETURNING_IN_DEFEAT then
                        return quest:progressEvent(575)

                    -- Alternate messages while waiting in defeat.
                    elseif
                        questProgress == phase.WAITING_IN_DEFEAT and
                        not conquestWaitFinished
                    then
                        local nextDefeatMessage = (player:getCharVar(var.DEFEAT_MESSAGE) % #defeatedWaitingMessages) + 1

                        player:setCharVar(var.DEFEAT_MESSAGE, nextDefeatMessage)

                        return quest:progressEvent(defeatedWaitingMessages[nextDefeatMessage])
                    end
                end,
            },

            onEventFinish =
            {
                -- Victory; Wait gets set with Reward.
                [572] = function(player, csid, option, npc)
                    giveReward(player)
                    if quest:complete(player) then
                        quest:setVar(player, var.CONQUEST_WAIT, NextConquestTally())
                    end
                end,

                -- Repeat quest
                [573] = function(player, csid, option, npc)
                    if option == 1 then
                        startQuest(player)
                    end
                end,

                -- Repeat quest after failure (and waiting until next conquest).
                [574] = function(player, csid, option, npc)
                    startQuest(player)
                end,

                -- Player has failed and must wait until conquest to retry.
                [575] = function(player, csid, option, npc)
                    if quest:getVar(player, var.PROGRESS) == phase.RETURNING_IN_DEFEAT then
                        quest:setVar(player, var.CONQUEST_WAIT, NextConquestTally())
                        quest:setVar(player, var.PROGRESS, phase.WAITING_IN_DEFEAT)
                    end
                end,
            },
        },
    },
}

return quest
