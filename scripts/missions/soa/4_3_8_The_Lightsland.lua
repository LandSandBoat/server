-----------------------------------
-- The Lightsland
-- Seekers of Adoulin M4-3-8
-----------------------------------
-- !addmission 12 91
-- Levil          : !pos -87.204 3.350 12.655 256
-- Ploh Trishbahk : !pos 100.580 -40.150 -63.830 257
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_LIGHTSLAND)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.THE_LIGHT_OF_DAWN_COMES },
}

local rewardItems =
{
    xi.item.ADOULINS_REFUGE,
    xi.item.YGNASS_RESOLVE,
    xi.item.ARCIELAS_GRACE,
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Option') == 0 then
                        return mission:progressEvent(1529, 257, 16744959, utils.MAX_UINT32 - 1023, 0, 0, 1228, 327, 0)
                    else
                        return mission:progressEvent(1531, 257, 23, 2964, 0, 0, 1999, 1999, 0)
                    end
                end,
            },

            onEventUpdate =
            {
                [1529] = function(player, csid, option, npc)
                    if option == 4 then
                        player:updateEvent(257, 0, 5, utils.MAX_UINT32 - 1415568507, utils.MAX_UINT32 - 964509701, 201326591, 3, 4)
                    else
                        player:updateEvent(option)
                    end
                end,

                [1531] = function(player, csid, option, npc)
                    if option == 4 then
                        player:updateEvent(257, 1, 2, 0, 0, 1999, 1999, 4)
                    else
                        player:updateEvent(option)
                    end
                end,
            },

            onEventFinish =
            {
                [1529] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, rewardItems[option]) then
                        mission:complete(player)
                        xi.mission.setVar(player, xi.mission.log_id.SOA, xi.mission.id.soa.THE_LIGHT_OF_DAWN_COMES, 'Timer', VanadielUniqueDay() + 1)
                    else
                        mission:setVar(player, 'Option', 1)
                    end

                    -- Experience is given after this cutscene regardless of mission complete.
                    player:addExp(500 * xi.settings.EXP_RATE)
                end,

                [1531] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, rewardItems[option]) then
                        mission:complete(player)
                        xi.mission.setVar(player, xi.mission.log_id.SOA, xi.mission.id.soa.THE_LIGHT_OF_DAWN_COMES, 'Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:progressEvent(166),
        },

        [xi.zone.LEAFALLIA] =
        {
            ['Heroic_Footprints'] = mission:progressEvent(5, 281, 0, 1756, 0, 58029558, 583232, 4095, 131184),
        },
    },
}

return mission
