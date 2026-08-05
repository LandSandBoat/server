-----------------------------------
-- Rubbish Day
-----------------------------------
-- Log ID: 3, Quest ID: 13
-- Chululu : !pos -13 -6 -42 245
-- Mashira : !pos 141 -6 138 200
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.RUBBISH_DAY)

quest.reward =
{
    gil  = 6000,
    item = xi.item.CHAIN_CHOKER,
}

local compatibilityReplies =
{
    DEFAULT     = 0, --  Used for a valid partner; 'Your partner doesn't seem to be nearby.' when no partner is matched.
    CHULULU     = 1, -- 'What? With me!? Spare me.'
    KUROU_MOROU = 2, -- 'What? With that creep? Over my dead body!'
    EMPTY       = 3, -- 'Please fill in your partner's name.'
}

-- TODO: Returned bits may be based off of name or other factors. Requires significant captures. For now, this is one of each reply, chosen randomly.
local eventBits =
{
    { 4, 3, 5, 8, 2, 2, 0, 0 },
    { 4, 3, 5, 8, 1, 2, 0, 0 },
    { 2, 1, 0, 0, 0, 1, 0, 0 },
    { 3, 1, 0, 0, 0, 1, 0, 0 },
    { 8, 3, 1, 1, 1, 2, 1, 0 },
    { 8, 3, 5, 8, 2, 1, 1, 0 },
}

-- Resolves a typed partner name to (matchedId, reply) for the compatibility reading.
local function checkCompatibilityString(player, name)
    if name == '' then
        return 0, compatibilityReplies.EMPTY
    end

    local input = string.lower(name)

    if input == 'chululu' then
        return 0, compatibilityReplies.CHULULU
    elseif input == 'kurou-morou' then
        return 0, compatibilityReplies.KUROU_MOROU
    end

    local partner = GetPlayerByName(name)

    if
        partner and
        partner:getID() ~= player:getID() and
        partner:getZoneID() == player:getZoneID()
    then
        return partner:getID(), compatibilityReplies.DEFAULT
    end

    return 0, compatibilityReplies.DEFAULT
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.COLLECT_TARUT_CARDS) == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Chululu'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') >= 3 and
                        quest:getVar(player, 'Day') ~= VanadielUniqueDay()
                    then
                        return quest:progressEvent(198) -- Offers the quest
                    else
                        return quest:progressEvent(199) -- Compatibility test; first completed reading each day counts, but can get unlimited readings until you are offered the quest.
                    end
                end,
            },

            onEventUpdate =
            {
                [199] = function(player, csid, option, npc)
                    if type(option) == 'string' then
                        player:updateEvent(player:getID(), checkCompatibilityString(player, option))

                    elseif option ~= 0 then
                        local partner = GetPlayerByID(option)

                        if
                            partner and
                            partner:getZoneID() == player:getZoneID()
                        then
                            if quest:getVar(player, 'Day') ~= VanadielUniqueDay() then
                                quest:setVar(player, 'Prog', quest:getVar(player, 'Prog') + 1)
                                quest:setVar(player, 'Day', VanadielUniqueDay())
                            end

                            player:updateEvent(unpack(eventBits[math.randomInt(1, #eventBits)]))
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [198] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.MAGIC_TRASH)
                        quest:setVar(player, 'Prog', 0)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Chululu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(197) -- Finishes the quest
                    else
                        return quest:event(49) -- Reminder
                    end
                end,
            },

            onEventFinish =
            {
                [197] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addFame(xi.fameArea.SANDORIA, 13)
                        player:addFame(xi.fameArea.BASTOK, 13)
                        player:addFame(xi.fameArea.WINDURST, 13)
                    end
                end,
            },
        },

        [xi.zone.GARLAIGE_CITADEL] =
        {
            ['Mashira'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(11, 1)
                    end
                end,
            },

            onEventFinish =
            {
                [11] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.MAGIC_TRASH)
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },
}

return quest
