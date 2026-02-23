-----------------------------------
-- First Contact
-----------------------------------
-- !addquest 8 167
-- qm3 : !pos -179 8 254 102
-- Flagged on completion of Dawn of Death.
-- Click ??? in La Theine Plateau between 18:00 and 5:00. Flags An Officer and a Pirate upon completion.
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.FIRST_CONTACT)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                VanadielHour() >= 18 and
                VanadielHour() < 5
        end,

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['qm3'] = quest:progressEvent(11),

            onEventFinish =
            {
                [11] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.AN_OFFICER_AND_A_PIRATE)
                    end
                end,
            },
        },
    },
}

return quest
