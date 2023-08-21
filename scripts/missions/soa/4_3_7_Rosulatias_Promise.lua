-----------------------------------
-- Rosulatia's Promise
-- Seekers of Adoulin M4-3-7
-----------------------------------
-- !addmission 12 90
-- Levil             : !pos -87.204 3.350 12.655 256
-- Heroic Footprints : !pos -19.381 -0.403 17.465 281
-----------------------------------
local leafalliaID = zones[xi.zone.LEAFALLIA]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.ROSULATIAS_PROMISE)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_LIGHTSLAND },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:progressEvent(166),
        },

        [xi.zone.LEAFALLIA] =
        {
            ['Heroic_Footprints'] = mission:progressEvent(3, 0, 2957690, 1756, 0, 58029558, 583232, 4095, 131184),

            onEventUpdate =
            {
                [3] = function(player, csid, option, npc)
                    if option == 1 then
                        player:updateEvent(3, 0, 1756, 0, 58029558, 583232, 4905, 131184)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.WORLD_TREE_SAPLING)
                        player:messageSpecial(leafalliaID.text.LOST_KEYITEM, xi.ki.WORLD_TREE_SAPLING)
                    end
                end,
            },
        },
    },
}

return mission
