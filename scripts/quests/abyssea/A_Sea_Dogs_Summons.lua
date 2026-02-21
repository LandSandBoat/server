-----------------------------------
-- A Sea Dog's Summons
-----------------------------------
-- !addquest 8 180
-- Flagged on completion of Champions of Abyssea.
-- Zone into the Hall of the Gods between 18:00 and 5:00. Flags Death and Rebirth upon completion.
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_SEA_DOGS_SUMMONS)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                VanadielHour() >= 18 and
                VanadielHour() < 5
        end,

        [xi.zone.HALL_OF_THE_GODS] =
        {
            onZoneIn = function(player, prevZone)
                return 6
            end,

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DEATH_AND_REBIRTH)
                    end
                end,
            },
        },
    },
}

return quest
