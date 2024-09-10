-----------------------------------
-- Traitor in the Midst
-- Wings of the Goddess Mission 18
-----------------------------------
-- !addmission 5 17
-- Regal Pawprints (Aon)     : !pos -23.803 -60.055 -72.156 136
-- Regal Pawprints (Ceithir) : !pos -167.699 -39.981 -223.946 136
-- Regal Pawprints (Tri)     : !pos -329.921 -100.144 130.278 136
-- Regal Pawprints (Seachd)  : !pos 96.053 -19.959 127.652 136
-- Regal Pawprints (Coig)    : !pos 272.314 0.02 -23.815 136
-- Regal Pawprints (Naoi)    : !pos 53.812 0.307 -299.136 136
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.TRAITOR_IN_THE_MIDST)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.BETRAYAL_AT_BEAUCEDINE },
}

local gameOnTrigger = function(player, npc)
    local pawprintNum  = tonumber(string.sub(npc:getName(), -1))

    if not mission:isVarBitsSet(player, 'Status', pawprintNum - 3) then
        return mission:progressEvent(pawprintNum + 5)
    end
end

local gameOnEventUpdate = function(player, csid, option, npc)
    if
        option == 1 and
        mission:getLocalVar(player, 'Timer') == 0
    then
        mission:setLocalVar(player, 'Timer', os.time())
    elseif option == 2 then
        mission:setLocalVar(player, 'Timer', 0)
    end
end

local gameOnEventFinish = function(player, csid, option, npc)
    local pawprintNum  = tonumber(string.sub(npc:getName(), -1))
    local requiredTime = pawprintNum <= 5 and 20 or 0

    if
        option == 1 and
        os.time() - mission:getLocalVar(player, 'Timer') >= requiredTime
    then
        mission:setVarBit(player, 'Status', pawprintNum - 3)
    end

    mission:setLocalVar(player, 'Timer', 0)
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        -- TODO: Jul 2022 Update will change retry conditions for these minigames.  Not implementing the required
        -- zoning logic until that time.  Option 2 on event finish is the failure scenario.

        [xi.zone.BEAUCEDINE_GLACIER_S] =
        {
            ['Regal_Pawprints_3'] =
            {
                onTrigger = gameOnTrigger,
            },

            ['Regal_Pawprints_4'] =
            {
                onTrigger = gameOnTrigger,
            },

            ['Regal_Pawprints_5'] =
            {
                onTrigger = gameOnTrigger,
            },

            ['Regal_Pawprints_6'] =
            {
                onTrigger = gameOnTrigger,
            },

            ['Regal_Pawprints_7'] =
            {
                onTrigger = gameOnTrigger,
            },

            ['Regal_Pawprints_1'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: See if there is reminder text or event at this point prior to completing the required
                    -- minigames.

                    if mission:getVar(player, 'Status') == 31 then
                        return mission:progressEvent(14, 136, 300, 200, 100, 0, 9306117, 0, 0)
                    end
                end,
            },

            onEventUpdate =
            {
                [8]  = gameOnEventUpdate,
                [9]  = gameOnEventUpdate,
                [10] = gameOnEventUpdate,
                [11] = gameOnEventUpdate,
                [12] = gameOnEventUpdate,
            },

            onEventFinish =
            {
                [8]  = gameOnEventFinish,
                [9]  = gameOnEventFinish,
                [10] = gameOnEventFinish,
                [11] = gameOnEventFinish,
                [12] = gameOnEventFinish,

                [14] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
