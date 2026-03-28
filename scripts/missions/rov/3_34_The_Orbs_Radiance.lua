-----------------------------------
-- The Orb's Radiance
-- Rhapsodies of Vana'diel Mission 3-34
-----------------------------------
-- !addmission 13 224
-- Empyreal Paradox - Defeat Cloud of Darkness
-- NOTE: Retail requires defeating Cloud of Darkness. Stubbed to auto-complete.
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.THE_ORBS_RADIANCE)

mission.reward =
{
    keyItem     = xi.ki.SCINTILLATING_RHAPSODY,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.A_RHAPSODY_FOR_THE_AGES },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EMPYREAL_PARADOX] =
        {
            onZoneIn = function(player, prevZone)
                -- TODO: Implement Cloud of Darkness battlefield. Auto-completing for now.
                -- Retail also awards Cipher: Iroha II here but cipher item not in DB.
                mission:complete(player)
            end,
        },
    },
}

return mission
