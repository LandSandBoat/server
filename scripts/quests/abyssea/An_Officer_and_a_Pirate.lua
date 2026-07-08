-----------------------------------
-- An Officer and a Pirate
-----------------------------------
-- !addquest 8 168
-- Joachim : !pos -52.844 0 -9.978 246
-- Flagged on completion of First Contact.
-- Flags Heart of Madness upon completion.
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.AN_OFFICER_AND_A_PIRATE)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Joachim'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(334)
                end,
            },

            onEventFinish =
            {
                [334] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.HEART_OF_MADNESS)
                    end
                end,
            },
        },
    },
}

return quest
