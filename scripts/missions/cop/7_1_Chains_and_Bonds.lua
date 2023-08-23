-----------------------------------
-- Chains and Bonds
-- Promathia 7-1
-----------------------------------
-- !addmission 6 648
-- Walnut Door    : !pos 111 -41 41 26
-- Sewer Entrance : !pos 28 -12 44 26
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.CHAINS_AND_BONDS)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.FLAMES_IN_THE_DARKNESS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.LUFAISE_MEADOWS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 0 then
                        return 111
                    end
                end,
            },

            onEventUpdate =
            {
                [111] = function(player, csid, option, npc)
                    player:updateEvent(0, xi.item.DUCAL_GUARDS_RING)
                end,
            },

            onEventFinish =
            {
                [111] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.DUCAL_GUARDS_RING) then
                        mission:setVar(player, 'Status', 1)
                    end
                end,
            },
        },

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['_0qa'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Option', 0) then
                        return mission:progressEvent(115)
                    end
                end,
            },

            ['_0q1'] =
            {
                onTrigger = function(player, npc)
                    if not mission:isVarBitsSet(player, 'Option', 1) then
                        return mission:progressEvent(116)
                    end
                end,
            },

            ['Despachiaire']     = mission:event(318),
            ['Justinius']        = mission:event(135),

            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 114
                    end
                end,
            },

            onEventFinish =
            {
                [114] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,

                [115] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Option', 0)

                    if mission:getVar(player, 'Option') == 7 then
                        mission:complete(player)
                    end
                end,

                [116] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Option', 1)

                    if mission:getVar(player, 'Option') == 7 then
                        mission:complete(player)
                    end
                end,
            },
        },

        [xi.zone.SEALIONS_DEN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if not mission:isVarBitsSet(player, 'Option', 2) then
                        return 14
                    end
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    mission:setVarBit(player, 'Option', 2)

                    if mission:getVar(player, 'Option') == 7 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
