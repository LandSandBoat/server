-----------------------------------
-- The Light Within
-- Seekers of Adoulin M5-5-1
-----------------------------------
-- !addmission 12 129
-- Ploh Trishbahk : !pos 100.580 -40.150 -63.830 257
-----------------------------------
local ceizakID = zones[xi.zone.CEIZAK_BATTLEGROUNDS]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.THE_LIGHT_WITHIN)

mission.reward = {}

local rewardItems =
{
    xi.item.ADOULIN_RING,
    xi.item.WOLTARIS_RING,
    xi.item.WEATHERSPOON_RING,
    xi.item.JANNISTON_RING,
    xi.item.RENAYE_RING,
    xi.item.GORNEY_RING,
    xi.item.HAVERTON_RING,
    xi.item.KARIEYH_RING,
    xi.item.VOCANE_RING,
    xi.item.THURANDAUT_RING,
    xi.item.SHNEDDICK_RING,
    xi.item.ORVAIL_RING,
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CEIZAK_BATTLEGROUNDS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        mission:getVar(player, 'Status') == 1 and
                        mission:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        return 30
                    end
                end,
            },

            onEventUpdate =
            {
                [30] = function(player, csid, option, npc)
                    if option == 2 then
                        -- TODO: Find the 'No?' response to retain the Bonnet KI.  This update may also
                        -- influence or update Arciela's Bond with the player.

                        player:updateEvent(10, 0, 100, 100, utils.MAX_UINT32 - 68382, 80, 629273, 0)
                    elseif option == 9 then
                        player:updateEvent(0, 300, 200, 100, 65955, 80, 629609, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [30] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                    player:delKeyItem(xi.ki.PRISTINE_HAIR_RIBBON)
                    player:messageSpecial(ceizakID.text.KEYITEM_LOST, xi.ki.PRISTINE_HAIR_RIBBON)
                    npcUtil.giveKeyItem(player, xi.ki.ARCIELAS_SKIRT)

                    player:setPos(5.54, 0.42, -6.55, 162, xi.zone.LEAFALLIA)
                end,
            },
        },

        [xi.zone.LEAFALLIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 2 then
                        return 13
                    end
                end,
            },

            onEventUpdate =
            {
                [13] = function(player, csid, option, npc)
                    if option == 0 then
                        player:updateEvent(281, 3899944, 1, 0, 6815078, 4654893, 4095, 393328)
                    end
                end,
            },

            onEventFinish =
            {
                [13] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 3)
                    player:setPos(427.93, 0.555, 178.2, 192, xi.zone.CEIZAK_BATTLEGROUNDS)
                end,
            },
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Ploh_Trishbahk'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = mission:getVar(player, 'Status')

                    if
                        missionStatus == 3 or
                        missionStatus == 4
                    then
                        local repeatParam = missionStatus - 2

                        return mission:progressEvent(1555, 257, 23, 2964, 0, repeatParam, 7719, 4095, 0)
                    end
                end,
            },

            onEventUpdate =
            {
                [1555] = function(player, csid, option, npc)
                    if option >= 1 and option <= 12 then
                        player:updateEvent(option, 0, 2, 4000, 1, 0, 0, 4)
                    elseif option == 13 then
                        player:updateEvent(14, 6, 0, 0, 1, 0, 4480, 12190)
                    elseif option == 19 then
                        player:updateEvent(19, 23, 2964, 2, 2, 200, 2537, 8449)
                    end
                end,
            },

            onEventFinish =
            {
                [1555] = function(player, csid, option, npc)
                    if option >= 1 and option <= 12 then
                        if npcUtil.giveItem(player, { rewardItems[option], xi.item.COUNCILORS_GARB, xi.item.COUNCILORS_CUFFS }) then
                            -- NOTE: This mission is not completed here.  Since we started the Status for this mission at 1, reset
                            -- to 0 to signal that it has been completed and avoid 'forever' charVars

                            mission:setVar(player, 'Status', 0)
                        end
                    elseif option == 19 then
                        mission:setVar(player, 'Status', 4)
                    end
                end,
            },
        },
    },
}

return mission
