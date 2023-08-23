-----------------------------------
-- Melvien de Malecroix
-- Seekers of Adoulin M4-1-1
-----------------------------------
-- !addmission 12 72
-- Levil        : !pos -87.204 3.350 12.655 256
-- Kipligg      : !pos -32 0 22 256
-- Port Storage : !pos 85.578 30.5 180.639 256
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.MELVIEN_DE_MALECROIX)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.COURIER_CATASTROPHE },
}

local missionItems =
{
    { xi.item.EFT_SKIN,                    5 },
    { xi.item.LOCK_OF_MANTICORE_HAIR,      4 },
    { xi.item.BUFFALO_HORN,                1 },
    { xi.item.SQUARE_OF_MANTICORE_LEATHER, 1 },
    { xi.item.SQUARE_OF_BUFFALO_LEATHER,   1 },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Kipligg'] = mission:progressEvent(162, 256, 1, 256),
            ['Levil']   = mission:event(161),

            ['Port_Storage'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: This item is reportedly determined by the level of the player's bond with Arciela,
                    -- and could possibly be related to choices made with optional dialogue during previous missions
                    -- where an event update is displayed.  Until this is determined, randomly select item.
                    -- Reference: http://www.famitsu.com/news/201412/12067432.html

                    local selectedSet = math.random(1, #missionItems)

                    xi.mission.setVar(player, xi.mission.log_id.SOA, xi.mission.id.soa.COURIER_CATASTROPHE, 'Option', selectedSet)

                    return mission:progressEvent(156,
                        xi.item.EFT_SKIN,
                        xi.item.LOCK_OF_MANTICORE_HAIR,
                        xi.item.BUFFALO_HORN,
                        xi.item.SQUARE_OF_MANTICORE_LEATHER,
                        xi.item.SQUARE_OF_BUFFALO_LEATHER,
                        missionItems[selectedSet][1],
                        missionItems[selectedSet][2]
                    )
                end,
            },

            onEventFinish =
            {
                [156] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
