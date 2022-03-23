-----------------------------------
-- Numbering Days
-- Rhapsodies of Vana'diel Mission 2-6
-----------------------------------
-- !addmission 13 54
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
require("scripts/globals/rhapsodies")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.DESERT_WINDS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.EVER_FORWARD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    -- if xi.rhapsodies.charactersAvailable(player) then
                        return 164
                    -- end
                end,
            },

            onEventUpdate =
            {
                [164] = function(player, csid, option, npc)

                    -- Same event for id 164 and 165 couldnt see the difference
                    -- I found 3 parameter that affect the cs
                    -- option 0-x-x talk about talk about Salaheem's sentinels
                    -- option 1-x-x talk about you would make a most unwelcome guest
                    -- option 2-x-x no unwelcome message
                    -- option 1-1-x, 2-1-x talk about alchemist at the palace whisper about Ghatsad's Astral Candescence 
                    -- option x-x-0 Is normal greeting from tenzen
                    -- option x-x-1 Is tenzen thinking you might be upset whit him

                    local toauProgress = player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.IMMORTAL_SENTRIES and 1 or 0

                    if toauProgress ~= 0 then
                        toauProgress = player:getCurrentMission(xi.mission.log_id.TOAU) <= xi.mission.id.toau.ROYAL_PUPPETEER and 1 or 2
                    end

                    -- I dont have enough knowledge of story to infer Ghatsad and upset tenzen trigger
                   return player:updateEvent(toauProgress, 0, 0, 0, 0, 0, 0, 0, 0)

                end,
            },

            onEventFinish =
            {
                [164] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
