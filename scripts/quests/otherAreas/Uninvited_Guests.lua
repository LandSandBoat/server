-----------------------------------
-- Uninvited Guests
-----------------------------------
-- Log ID: 4, Quest ID: 81
-- Justinius    : !pos 76 -34 68 26
-- Monarch Linn : !zone 31
-----------------------------------
require('scripts/globals/common')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

--[[
    UninvitedGuestsStatus
    1 = Accepted
    2 = Won
    3 = Lost
    4 = On Cooldown Due to Loss
]]

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNINVITED_GUESTS)

local rewards =
{
    { droprate = 509, rewardId =  4247 }, -- Miratete's Memoirs
    { droprate = 35,  rewardId =  4550 }, -- Bream Risotto
    { droprate = 30,  rewardId =  1132 }, -- Raxa
    { droprate = 30,  rewardId =  5144 }, -- Crimson Jelly
    { droprate = 30,  rewardId =  4279 }, -- Tavnazian Salad
    { droprate = 29,  rewardId =   678 }, -- Aluminum Ore
    { droprate = 29,  rewardId =  5142 }, -- Bison Steak
    { droprate = 29,  rewardId =  4544 }, -- Mushroom Stew
    { droprate = 27,  rewardId =  1766 }, -- Tiger Eye
    { droprate = 24,  rewardId =  1841 }, -- Unicorn Horn
    { droprate = 24,  rewardId =    61 }, -- Armoire
    { droprate = 24,  rewardId =  1602 }, -- Mannequin Body
    { droprate = 21,  rewardId =  4434 }, -- Mushroom Risotto
    { droprate = 19,  rewardId =  1603 }, -- Mannequin Hands
    { droprate = 18,  rewardId =  1770 }, -- Oversized Fang
    { droprate = 18,  rewardId =  1771 }, -- Dragon Bone
    { droprate = 16,  rewardId =   690 }, -- Elm Log
    { droprate = 15,  rewardId =  1604 }, -- Mannequin Legs
    { droprate = 11,  rewardId =  1605 }, -- Mannequin Feet
    { droprate = 11,  rewardId =   646 }, -- Adaman Ore
    { droprate = 11,  rewardId =   860 }, -- Behemoth Hide
    { droprate = 10,  rewardId =  1765 }, -- Habu Skin
    { droprate = 7,   rewardId =  1842 }, -- Cloud Evoker
    { droprate = 7,   rewardId =  1601 }, -- Mannequin Head
    { droprate = 6,   rewardId =   739 }, -- Orichalcum  Ore
    { droprate = 4,   rewardId =  5158 }, -- Vermillion Jelly
    { droprate = 4,   rewardId =  5185 }, -- Leremieu Salad
    { droprate = 3,   rewardId =   908 }, -- Adamantoise Shell
    { droprate = 3,   rewardId =  1312 }, -- Angel Skin
    { droprate = 3,   rewardId =  4486 }, -- Dragon Heart
    { droprate = 3,   rewardId =  5157 }, -- Marbled Steak
    { droprate = 3,   rewardId =  4268 }, -- Sea Spray Risotto
    { droprate = 3,   rewardId =  1313 }, -- Siren's Hair
    { droprate = 3,   rewardId =  5264 }, -- Yellow Liquid
    { droprate = 2,   rewardId =  4330 }, -- Witch Risotto
    { droprate = 2,   rewardId =     1 }, -- 10,000 Gil Speical cased to ID 1
    { droprate = 2,   rewardId = 14470 }, -- Assault Breastplate
    { droprate = 2,   rewardId =  4344 }, -- Witch Stew
}

local updateUninvitedGuests = function(player, clearVars)
    player:setCharVar("UninvitedGuestsReset", getConquestTally())
    if clearVars then
        player:setCharVar("UninvitedGuestsStatus", 0)
        player:setCharVar("UninvitedGuestsReward", 0)
    end
end

local generateUninvitedGuestsReward = function(player)
    -- Reward info taken from https://ffxiclopedia.fandom.com/wiki/Uninvited_Guests
    -- Moved any value with a 0 to 0.1
    -- Reduced Miratete's Memoirs from 57.7% to 50.9% to align total reward percentage to 100%
    local max = 0
    local rewardId = 0

    for _, entry in pairs(rewards) do
        max = max + entry.droprate
    end

    local roll = math.random(max)

    for _, entry in pairs(rewards) do
        max = max - entry.droprate

        if roll > max then
            rewardId = entry.rewardId
            break
        end
    end

    player:setCharVar("UninvitedGuestsReward", rewardId)
    return rewardId
end

quest.reward =
{
    title = xi.title.MONARCH_LINN_PATROL_GUARD,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SAVAGE)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Justinius'] = quest:progressEvent(570),

            onEventFinish =
            {
                [570] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.MONARCH_LINN_PATROL_PERMIT)
                        quest:begin(player)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return (status == QUEST_ACCEPTED) or (status == QUEST_COMPLETED)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Justinius'] =
            {
                onTrigger = function(player, npc)
                    local uninvitedGuests = player:getCharVar("UninvitedGuestsStatus")
                    local questStatus = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNINVITED_GUESTS)
                    -- Reminder to go to Monarch Linn
                    if
                        uninvitedGuests == 1 and
                        questStatus == QUEST_ACCEPTED
                    then
                        return quest:progressEvent(571)
                    -- Player won, give reward
                    elseif uninvitedGuests == 2 then
                        return quest:progressEvent(572)
                    -- Reissues permit post failure
                    elseif
                        uninvitedGuests == 4 and
                        player:getCharVar("UninvitedGuestsReset") <= os.time()
                    then
                        return quest:progressEvent(574)
                    -- Uninvited Guests Failure - mocks player until conquest tally
                    elseif
                        uninvitedGuests == 3 or
                        (uninvitedGuests == 4 and player:getCharVar("UninvitedGuestsReset") >= os.time())
                    then
                        return quest:progressEvent(575)
                    -- The repeat quest kick off
                    elseif
                        player:getCharVar("UninvitedGuestsReset") <= os.time() and
                        not player:hasKeyItem(xi.ki.MONARCH_LINN_PATROL_PERMIT)
                    then
                        return quest:progressEvent(573)
                    end
                end,
            },

            onEventFinish =
            {
                [572] = function(player, csid, option, npc)
                    -- Determine Reward (or check if a reward is pending)
                    local rewardId = player:getCharVar("UninvitedGuestsReward") -- Done to prevent ppl holding the r/ex xp page and forcing a recalculation
                    if rewardId == 0 then
                        rewardId = generateUninvitedGuestsReward(player)
                    end

                    if
                        rewardId == 1 and
                        quest:complete(player)
                    then -- special case for Gil
                        if npcUtil.giveCurrency(player, "gil", 10000) then
                            updateUninvitedGuests(player, true)
                        end
                    elseif quest:complete(player) then -- Reward item
                        if npcUtil.giveItem(player, rewardId) then
                            updateUninvitedGuests(player, true)
                        end
                    end
                end,

                [573] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.MONARCH_LINN_PATROL_PERMIT)
                        player:setCharVar("UninvitedGuestsStatus", 1) -- accepted
                    end
                end,

                [574] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.MONARCH_LINN_PATROL_PERMIT)
                    player:setCharVar("UninvitedGuestsStatus", 1) -- accepted
                end,

                [575] = function(player, csid, option, npc)
                    -- Player has failed and must wait until conquest to retry
                    if player:getCharVar("UninvitedGuestsStatus") == 3 then
                        updateUninvitedGuests(player, false)
                        player:setCharVar("UninvitedGuestsStatus", 4)
                    end
                end,
            },
        },
    },
}

return quest
