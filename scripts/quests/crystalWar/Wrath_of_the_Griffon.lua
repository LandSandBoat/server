-----------------------------------
-- Boy and the Beast
-----------------------------------
-- !addquest 7 25
-- Rholont : !pos -168 -2 56 80
-- qm8     : !pos -6 0 -295 82
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local jugnerSID = require('scripts/zones/Jugner_Forest_[S]/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.WRATH_OF_THE_GRIFFON)

quest.reward =
{
    keyItem = xi.ki.MILITARY_SCRIP,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BOY_AND_THE_BEAST)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            ['Rholont'] = quest:progressEvent(59),

            onEventFinish =
            {
                [59] = function(player, csid, option, npc)
                    quest:begin(player)
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
                    if quest:getVar(player, 'Prog') < 3 then
                        return quest:event(61)
                    else
                        return quest:progressEvent(60)
                    end
                end,
            },

            onEventFinish =
            {
                [60] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        xi.quest.setVar(player, xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.PERILS_OF_THE_GRIFFON, 'Timer', VanadielUniqueDay() + 1)
                        xi.quest.setMustZone(player, xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.PERILS_OF_THE_GRIFFON)
                    end
                end,
            },
        },

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['qm8'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(204)
                    elseif
                        questProgress == 1 and
                        not GetMobByID(jugnerSID.mob.COBRACLAW_BUCHZVOTCH):isSpawned()
                    then
                        return quest:progressEvent(205)
                    elseif questProgress == 2 then
                        return quest:progressEvent(206)
                    end
                end,
            },

            ['Cobraclaw_Buchzvotch'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 1 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,
            },

            onEventFinish =
            {
                [204] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [205] = function(player, csid, option, npc)
                    SpawnMob(jugnerSID.mob.COBRACLAW_BUCHZVOTCH):updateClaim(player)
                end,

                [206] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },
    },
}

return quest
