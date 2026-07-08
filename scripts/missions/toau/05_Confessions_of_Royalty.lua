-----------------------------------
-- Confessions of Royalty
-- Aht Uhrgan Mission 5
-----------------------------------
-- !addmission 4 4
-- Halver : !pos 2 0.1 0.1 233
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.CONFESSIONS_OF_ROYALTY)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.EASTERLY_WINDS },
}

local function canEnterChateau(player)
    local pNation = player:getNation()
    local pRank   = player:getRank(pNation)

    -- Everyone can enter at rank 3.
    if pRank >= 3 then
        return true
    end

    -- Sandoria citizens gain access at rank 2.
    if
        pNation == xi.nation.SANDORIA and
        pRank >= 2
    then
        return true
    end

    -- Other citizens gain access during "The emisary"/"The three Kingdoms"
    if
        pNation ~= xi.nation.SANDORIA and
        player:getCurrentMission(pNation) >= 5
    then
        return true
    end

    return false
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Cacaroon'] = mission:event(3023, { text_table = 0 }),

            ['Nadeey'] = mission:event(3025, { text_table = 0 }),

            ['Naja_Salaheem'] = mission:event(3021, { text_table = 0 }),
        },

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.RAILLEFALS_LETTER) then
                        return mission:progressEvent(564)
                    end
                end,
            },

            -- Forces the player into the CS if they don't normall have access to the Chateau.
            onZoneIn = function(player, prevZone)
                if mission:getVar(player, 'Option') == 1 then
                    return 563
                end
            end,

            onEventFinish =
            {
                -- Force zones the player out of the Chateau if they don't have access.
                [563] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.RAILLEFALS_LETTER)
                    mission:complete(player)
                    player:setPos(0, 0, 100, 64, xi.zone.NORTHERN_SAN_DORIA)
                end,

                [564] = function(player, csid, option, npc)
                    if option == 1 then
                        player:delKeyItem(xi.ki.RAILLEFALS_LETTER)
                        mission:complete(player)
                    end
                end,
            },
        },

        -- Unique interaction IF the player does not have access to the Chateau to gain access to continue the mission.
        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Guilerme'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.RAILLEFALS_LETTER) and
                        not canEnterChateau(player)
                    then
                        return mission:progressEvent(810)
                    end
                end,
            },

            onEventFinish =
            {
                [810] = function(player, csid, option, npc)
                    -- Force zones the player into the Chateau
                    if option == 1 then
                        mission:setVar(player, 'Option', 1)
                        player:setPos(0, 0, -13, 192, xi.zone.CHATEAU_DORAGUILLE)
                    end
                end,
            },
        },
    },
}

return mission
