-----------------------------------
-- Burgeoning Dread
-- A Shantotto Ascension M2
-----------------------------------
-- !addmission 11 1
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD },
}

-- The event takes the kit's index. The next mission stores the item id.
local kits =
{
    xi.item.ENFEEBLEMENT_KIT_OF_POISON,
    xi.item.ENFEEBLEMENT_KIT_OF_BLINDNESS,
    xi.item.ENFEEBLEMENT_KIT_OF_SLEEP,
    xi.item.ENFEEBLEMENT_KIT_OF_SILENCE,
}

local function pickKit(player, csid, option, npc)
    local kitIndex = math.randomInt(1, #kits)
    xi.mission.setVar(player, xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD, 'Option', kits[kitIndex])
    player:updateEvent(kitIndex - 1)
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EAST_SARUTABARUTA] =
        {
            onZoneIn = function(player, prevZone)
                if
                    prevZone == xi.zone.WINDURST_WOODS and
                    not player:hasStatusEffect(xi.effect.MOUNTED)
                then
                    return 71
                end
            end,

            onEventUpdate =
            {
                [71] = pickKit,
            },

            onEventFinish =
            {
                [71] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.WEST_SARUTABARUTA] =
        {
            onZoneIn = function(player, prevZone)
                if prevZone == xi.zone.WINDURST_WATERS then
                    return 62
                elseif prevZone == xi.zone.PORT_WINDURST then
                    return 63
                end
            end,

            onEventUpdate =
            {
                [62] = pickKit,
                [63] = pickKit,
            },

            onEventFinish =
            {
                [62] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [63] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
