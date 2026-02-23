-----------------------------------
-- Death and Rebirth
-----------------------------------
-- !addquest 8 181
-- Joachim : !pos -52.844 0 -9.978 246
-- Flagged on completion of A Sea Dog's Summons.
-- Complete all 9 zone quests, then talk to Joachim. Zone into the Hall of the Gods between 18:00 and 5:00. Flags Emissaries of God upon completion.
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DEATH_AND_REBIRTH)

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

local function allZoneQuestsComplete(player)
    for _, questId in ipairs(zoneQuests) do
        if not player:hasCompletedQuest(xi.questLog.ABYSSEA, questId) then
            return false
        end
    end

    return true
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and allZoneQuestsComplete(player)
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Joachim'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(343)
                end,
            },

            onEventFinish =
            {
                [343] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and quest:getVar(player, 'Prog') == 1
        end,

        [xi.zone.HALL_OF_THE_GODS] =
        {
            onZoneIn = function(player, prevZone)
                local hour = VanadielHour()
                if hour >= 18 or hour < 5 then
                    return 7
                end
            end,

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.EMISSARIES_OF_GOD)
                    end
                end,
            },
        },
    },
}

return quest
