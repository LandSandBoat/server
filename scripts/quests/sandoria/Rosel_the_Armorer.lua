-----------------------------------
-- Rosel the Armorer
-----------------------------------
-- Log ID: 0, Quest ID: 2
-- Rosel    : !pos 69.895 0 41.073 230
-- Guilerme : !pos -4.5 0 99 231
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.ROSEL_THE_ARMORER)

quest.reward =
{
    -- Delivered to correct Prince: 200G, Incorrect Prince: 100G
    title = xi.title.ENTRANCE_DENIED,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Rosel'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')
                    local questStage = quest:getVar(player, 'Stage')

                    -- On triggering this CS, set a value to determine if Pieuje or Trion is the intended
                    -- recipient.  This will persist until the quest is completed, and is one higher than
                    -- the parameter value (1 == Pieuje, 2 == Trion)

                    -- Using questStage directly eliminates the need for an additional questProgress state
                    -- and the subsequent need for an additional db write on that change.
                    if questStage == 0 then
                        questStage = math.random(1, 2)
                        quest:setVar(player, 'Stage', questStage)
                    end

                    if questProgress == 0 then
                        return quest:progressEvent(523, 0, 0, 0, 0, questStage - 1)
                    elseif questProgress == 1 then
                        return quest:progressEvent(524, 0, 0, 0, 0, questStage - 1)
                    end
                end,
            },

            onEventFinish =
            {
                [523] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.RECEIPT_FOR_THE_PRINCE)
                    else
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [524] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.RECEIPT_FOR_THE_PRINCE)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Rosel'] =
            {
                onTrigger = function(player, npc)
                    local questStage = quest:getVar(player, 'Stage')
                    if player:hasKeyItem(xi.ki.RECEIPT_FOR_THE_PRINCE) then
                        return quest:progressEvent(524, 0, 0, 0, 0, questStage - 1)
                    else
                        local questOption = quest:getVar(player, 'Option')
                        return quest:progressEvent(527, 0, 0, 0, 0, questStage - 1, questOption)
                    end
                end,
            },

            onEventFinish =
            {
                [527] = function(player, csid, option, npc)
                    local gilReward = 100

                    if option == 0 then
                        gilReward = 200
                    end

                    npcUtil.giveCurrency(player, 'gil', gilReward)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Guilerme'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.RECEIPT_FOR_THE_PRINCE) then
                        local questStage = quest:getVar(player, 'Stage')
                        return quest:progressEvent(507, 0, 0, 0, 0, 0, 0, questStage - 1)
                    end
                end,
            },

            onEventFinish =
            {
                [507] = function(player, csid, option, npc)
                    -- The option returned from this event determines whether the player
                    -- has chosen correctly or not.  Option 0 is correct answer, while
                    -- option 1 was an incorrect answer.
                    quest:setVar(player, 'Option', option)
                    player:delKeyItem(xi.ki.RECEIPT_FOR_THE_PRINCE)
                end,
            },
        },
    },
}

return quest
