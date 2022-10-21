-----------------------------------
-- Claws of the Griffon
-----------------------------------
-- !addquest 7 15
-- Rholont : !pos -168 -2 56 80
-- qm6     : !pos 68 -0.5 324 82
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local jugnerSID = require('scripts/zones/Jugner_Forest_[S]/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON)

quest.reward =
{
    item = xi.items.ANGELSTONE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {

            ['Rholont'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Timer') <= VanadielUniqueDay() then
                        return quest:progressEvent(47)
                    end
                end,
            },

            onEventFinish =
            {
                [47] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setMustZone(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rholont'] =
            {
                onTrigger = function(player, npc)
                    if
                        not quest:getMustZone(player) and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return quest:progressEvent(48)
                    else
                        local questOption = quest:getVar(player, 'Option')

                        if questOption == 0 then
                            return quest:progressEvent(50)
                        else
                            return quest:event(49)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [48] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [50] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,
            },
        },

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['qm6'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 2 then
                        return quest:progressEvent(201)
                    elseif
                        questProgress == 3 and
                        not GetMobByID(jugnerSID.mob.FINGERFILCHER_DRADZAD):isSpawned()
                    then
                        return quest:progressEvent(202)
                    elseif questProgress == 4 then
                        return quest:progressEvent(203)
                    end
                end,
            },

            ['Fingerfilcher_Dradzad'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.EAST_RONFAURE_S and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return 200
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [201] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [202] = function(player, csid, option, npc)
                    SpawnMob(jugnerSID.mob.FINGERFILCHER_DRADZAD):updateClaim(player)
                end,

                [203] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
