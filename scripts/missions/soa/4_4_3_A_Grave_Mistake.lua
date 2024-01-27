-----------------------------------
-- A Grave Mistake
-- Seekers of Adoulin M4-4-3
-----------------------------------
-- !addmission 12 96
-- Levil              : !pos -87.204 3.350 12.655 256
-- Ploh Trishbahk     : !pos 100.580 -40.150 -63.830 257
-- Sainene            : !pos 315 -5.768 -300 258
-- Stout_Weir         : !pos -427.506 -1 -48.217 258
-- Waterways Overlook : !pos -17.995 -6.507 37.43 258
-----------------------------------
local easternAdoulinID = zones[xi.zone.EASTERN_ADOULIN]
local ralaID           = zones[xi.zone.RALA_WATERWAYS]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.A_GRAVE_MISTAKE)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.AN_EMERGENCY_CONVOCATION },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Levil'] = mission:event(40, 256, 0, 0, 3, 1, 0, utils.max_UINT32, 4),
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 7 then
                        return mission:progressEvent(1534, 257, 0, 5, 0, 67108863, 1081558, 4095, 0)
                    else
                        return mission:progressEvent(1541, 257, 16744959, utils.MAX_UINT32 - 4095, 0, 4063, 1999, 1999, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [1534] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.BROKEN_FUSE)
                        player:messageSpecial(easternAdoulinID.text.LOST_KEYITEM, xi.ki.BROKEN_FUSE)
                        xi.mission.setMustZone(player, xi.mission.log_id.SOA, xi.mission.id.soa.AN_EMERGENCY_CONVOCATION)
                    end
                end,
            },
        },

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Sainene'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 0) then
                        return mission:progressEvent(372)
                    else
                        return mission:event(320)
                    end
                end,
            },

            ['Stout_Weir'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.BROKEN_FUSE) then
                        return mission:progressEvent(371)
                    else
                        return mission:event(373)
                    end
                end,
            },

            ['Waterways_Overlook'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Status', 1) then
                        mission:setVarBit(player, 'Status', 1)
                    end

                    return mission:messageSpecial(ralaID.text.A_QUICK_GLANCE_REVEALS)
                end,
            },

            onEventFinish =
            {
                [371] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Status', 2)
                    npcUtil.giveKeyItem(player, xi.ki.BROKEN_FUSE)
                end,

                [372] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Status', 0)
                end,
            },
        },
    },
}

return mission
