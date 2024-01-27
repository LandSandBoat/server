-----------------------------------
-- Trial by Earth
-----------------------------------
-- Log ID: 1, Quest ID: 61
-- Juroro : !pos 32 7 -41 236
-----------------------------------
local portBastokID = zones[xi.zone.PORT_BASTOK]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
}

local rewardItems =
{
    [0] = xi.item.TITANS_CUDGEL,
    [1] = xi.item.EARTH_BELT,
    [2] = xi.item.EARTH_RING,
    [3] = xi.item.DOSE_OF_DESERT_LIGHT,
}

local function getRewardMask(player)
    local rewardMask = 0

    for bitNum, itemId in pairs(rewardItems) do
        if player:hasItem(itemId) then
            rewardMask = utils.mask.setBit(rewardMask, bitNum, true)
        end
    end

    if player:hasSpell(xi.magic.spell.TITAN) then
        rewardMask = utils.mask.setBit(rewardMask, 5, true)
    end

    return rewardMask
end

local function giveQuestReward(player, eventOption)
    local wasRewarded = true

    if eventOption <= 4 then
        wasRewarded = npcUtil.giveItem(player, rewardItems[eventOption - 1])
    elseif eventOption == 5 then
        npcUtil.giveCurrency(player, 'gil', 10000)
    elseif eventOption == 6 then
        player:addSpell(xi.magic.spell.TITAN)
        player:messageSpecial(portBastokID.text.TITAN_UNLOCKED, 0, 0, 1)
    end

    return wasRewarded
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.BASTOK) >= 6
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Juroro'] = quest:progressEvent(249, 0, xi.ki.TUNING_FORK_OF_EARTH),

            onEventFinish =
            {
                [249] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_EARTH)
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

        [xi.zone.PORT_BASTOK] =
        {
            ['Juroro'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.WHISPER_OF_TREMORS) then
                        if not player:hasKeyItem(xi.ki.TUNING_FORK_OF_EARTH) then
                            -- Player has failed the BCNM and requires a new Tuning Fork

                            return quest:progressEvent(284, 0, xi.ki.TUNING_FORK_OF_EARTH)
                        else
                            return quest:event(250, 0, xi.ki.TUNING_FORK_OF_EARTH, 1)
                        end
                    else
                        return quest:progressEvent(252, 0, xi.ki.TUNING_FORK_OF_EARTH, 1, 0, getRewardMask(player))
                    end
                end,
            },

            onEventFinish =
            {
                [252] = function(player, csid, option, npc)
                    if giveQuestReward(player, option) then
                        quest:complete(player)
                        player:delKeyItem(xi.ki.WHISPER_OF_TREMORS)
                        quest:setTimedVar(player, 'Timer', NextJstDay())
                    end
                end,

                [284] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_EARTH)
                end,
            },
        },

        [xi.zone.CLOISTER_OF_TREMORS] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if player:getLocalVar('battlefieldWin') == 576 then
                        npcUtil.giveKeyItem(player, xi.ki.WHISPER_OF_TREMORS)
                        player:addTitle(xi.title.HEIR_OF_THE_GREAT_EARTH)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                quest:getVar(player, 'Timer') == 0
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Juroro'] = quest:progressEvent(249, 0, xi.ki.TUNING_FORK_OF_EARTH),

            onEventFinish =
            {
                [249] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH)

                        npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_EARTH)

                        quest:begin(player)
                    end
                end,
            },
        },
    },
}

return quest
