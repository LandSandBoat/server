-----------------------------------
-- The Empress Crowned
-- Aht Uhrgan Mission 47
-----------------------------------
-- !addmission 4 46
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.THE_EMPRESS_CROWNED)

mission.reward =
{
    item        = xi.item.GLORY_CROWN,
    title       = xi.title.ETERNAL_MERCENARY,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.ETERNAL_MERCENARY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    return mission:progressEvent(3144, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },

            onEventUpdate =
            {
                [3144] = function(player, csid, option, npc)
                    player:updateEvent(0, 1, 0, 0, 1, 1, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [3144] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
