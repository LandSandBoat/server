-----------------------------------
-- Dawn of Death
-----------------------------------
-- !addquest 8 162
-- Joachim : !pos -52.844 0 -9.978 246
-- Flagged on completion of The Truth Beckons.
-- Complete when any 3 of the 9 zone quests are completed and player talks to Joachim. Flags First Contact upon completion.
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH)

quest.reward = {}

local zoneQuests =
{
    xi.quest.id.abyssea.A_GOLDSTRUCK_GIGAS,
    xi.quest.id.abyssea.TO_PASTE_A_PEISTE,
    xi.quest.id.abyssea.MEGADRILE_MENACE,
    xi.quest.id.abyssea.THE_BEAST_OF_BASTORE,
    xi.quest.id.abyssea.A_DELECTABLE_DEMON,
    xi.quest.id.abyssea.A_FLUTTERY_FIEND,
    xi.quest.id.abyssea.A_BEAKED_BLUSTERER,
    xi.quest.id.abyssea.A_MAN_EATING_MITE,
    xi.quest.id.abyssea.AN_ULCEROUS_URAGNITE,
}

local function countCompletedZoneQuests(player)
    local count = 0
    for _, questId in ipairs(zoneQuests) do
        if player:hasCompletedQuest(xi.questLog.ABYSSEA, questId) then
            count = count + 1
        end
    end

    return count
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and countCompletedZoneQuests(player) >= 3
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Joachim'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(333)
                end,
            },

            onEventFinish =
            {
                [333] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.FIRST_CONTACT)
                    end
                end,
            },
        },
    },
}

return quest
