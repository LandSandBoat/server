-----------------------------------
-- Knight Stalker
-- !addquest 0 96
-----------------------------------
-- Ceraulian !gotoid 17727560
-- Rahal !gotoid 17731592
-- Kuftal Coffer !gotoid 17490304
-- Balasiel !gotoid 17719359
-- QM15 !gotoid 17428862
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/pets")
-----------------------------------
local uggalepihID = require("scripts/zones/Temple_of_Uggalepih/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER)

quest.reward =
{
    item     = xi.items. DRACHEN_ARMET,
    fame     = 60,
    fameArea = xi.quest.fame_area.SANDORIA,
    title    = xi.title.PARAGON_OF_DRAGOON_EXCELLENCE,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.DRG and
                player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL and
                player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.CHASING_QUOTAS) == QUEST_COMPLETED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Rahal'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'csSeen') == 0 then
                        return quest:progressEvent(121)
                    elseif quest:getVar(player, 'csSeen') == 1 then --Declined First Offering.
                        return quest:progressEvent(120)
                    end
                end,
            },

            onEventFinish =
            {
                [121] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'csSeen', 0)
                    else
                        quest:setVar(player, 'csSeen', 1) -- Declined First Offering.
                    end
                end,

                [120] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest.
                        quest:begin(player)
                        quest:setVar(player, 'csSeen', 0)
                    else
                        quest:setVar(player, 'csSeen', 1)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Rahal'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:event(119)
                    elseif player:hasKeyItem(xi.ki.CHALLENGE_TO_THE_ROYAL_KNIGHTS) then
                        if questProgress == 1 then
                            return quest:progressEvent(78)
                        elseif questProgress == 2 then
                            return quest:event(69)
                        elseif questProgress == 3 then
                            return quest:progressEvent(110)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [78] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [110] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Ceraulian'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(19)
                    elseif questProgress == 1 then
                        if not player:hasKeyItem(xi.ki.CHALLENGE_TO_THE_ROYAL_KNIGHTS) then
                            return quest:event(23)
                        end
                    else
                        return quest:event(20)
                    end
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Balasiel'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 2 then
                        return quest:progressEvent(63)
                    end
                end,
            },

            onEventFinish =
            {
                [63] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.TEMPLE_OF_UGGALEPIH] =
        {
            ['qm15'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')
                    local pet = player:getPet()

                    if
                        questProgress == 4 and
                        quest:getVar(player, 'nmKilled') == 0 and
                        player:getMainJob() == xi.job.DRG and
                        pet and
                        pet:getPetID() == xi.pet.id.WYVERN and
                        npcUtil.popFromQM(player, npc, { uggalepihID.mob.CLEUVARION_M_RESOAIX, uggalepihID.mob.ROMPAULION_S_CITALLE }, { hide = 0, claim = false })
                    then
                        return quest:messageSpecial(uggalepihID.text.WYVERN_REACTS)
                    elseif quest:getVar(player, 'nmKilled') == 1 then
                        return quest:progressEvent(67)
                    end
                end,
            },

            ['Rompaulion_S_Citalle'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        quest:getVar(player, 'Prog') == 4 and
                        GetMobByID(mob:getID() - 1):isDead()
                    then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },

            ['Cleuvarion_M_Resoaix'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        quest:getVar(player, 'Prog') == 4 and
                        GetMobByID(mob:getID() + 1):isDead()
                    then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [67] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.CHALLENGE_TO_THE_ROYAL_KNIGHTS)
                        quest:setVar(player, 'csOption1', 1)
                        quest:setVar(player, 'csOption2', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Ceraulian'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'csOption1') == 1 then
                        return quest:progressEvent(22)
                    end
                end,
            },

            onEventFinish =
            {
                [22] = function(player, csid, option, npc)
                    quest:setVar(player, 'csOption1', 0)
                end,
            },
        },

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Rahal'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'csOption2') == 1 then
                        return quest:progressEvent(118)
                    end
                end,
            },

            onEventFinish =
            {
                [118] = function(player, csid, option, npc)
                    quest:setVar(player, 'csOption2', 0)
                end,
            },
        },
    },
}

return quest
