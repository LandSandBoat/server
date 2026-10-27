-----------------------------------
-- Shantotto In Chains
-- A Shantotto Ascension M8
-----------------------------------
-- !addmission 11 7
-- Aldo             : !pos 19.7 3.9 -59 245
-- Ensorcelled Door : !pos -223.03 -7.8 -104 122
-----------------------------------
require('scripts/missions/asa/helpers')
-----------------------------------
local romaeveID = zones[xi.zone.ROMAEVE]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ASA, xi.mission.id.asa.SHANTOTTO_IN_CHAINS)

mission.reward =
{
    nextMission = { xi.mission.log_id.ASA, xi.mission.id.asa.FOUNTAIN_OF_TROUBLE },
}

local fragments =
{
    xi.keyItem.LUMINOUS_RED_FRAGMENT,
    xi.keyItem.LUMINOUS_BEIGE_FRAGMENT,
    xi.keyItem.LUMINOUS_GREEN_FRAGMENT,
    xi.keyItem.LUMINOUS_YELLOW_FRAGMENT,
    xi.keyItem.LUMINOUS_PURPLE_FRAGMENT,
    xi.keyItem.LUMINOUS_BLUE_FRAGMENT,
}

local iceEarthWaterDark    = set{ xi.damageType.ICE, xi.damageType.EARTH, xi.damageType.WATER, xi.damageType.DARK }
local fireWindThunderLight = set{ xi.damageType.FIRE, xi.damageType.WIND, xi.damageType.THUNDER, xi.damageType.LIGHT }

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] = mission:event(10102),
        },

        [xi.zone.ROMAEVE] =
        {
            ['Ensorcelled_Door'] =
            {
                onTrigger = function(player, npc)
                    if xi.asa.helpers.countKeyItems(player, fragments) == #fragments then
                        return mission:progressEvent(71, xi.zone.ROMAEVE)
                    end

                    return mission:sequence(
                        { text = romaeveID.text.DOOR_IS_LOCKED },
                        { text = romaeveID.text.HEXAGONAL_DEPRESSION })
                end,
            },

            -- The mob scripts record the killing blow. TODO: Capture needed, the rules come from the wiki.
            ['Steely_Weapon'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mob:getLocalVar('asaAttackType') == xi.attackType.RANGED then
                        npcUtil.giveKeyItem(player, xi.keyItem.LUMINOUS_YELLOW_FRAGMENT)
                    end
                end,
            },

            ['Fired_Urn'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mob:getLocalVar('asaDamageType') == xi.damageType.SLASHING then
                        npcUtil.giveKeyItem(player, xi.keyItem.LUMINOUS_PURPLE_FRAGMENT)
                    end
                end,
            },

            ['Lode_Golem'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        mob:getLocalVar('asaAttackType') == xi.attackType.MAGICAL and
                        iceEarthWaterDark[mob:getLocalVar('asaDamageType')]
                    then
                        npcUtil.giveKeyItem(player, xi.keyItem.LUMINOUS_BLUE_FRAGMENT)
                    end
                end,
            },

            onEventFinish =
            {
                [71] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        xi.asa.helpers.delKeyItems(player, fragments)
                    end
                end,
            },
        },

        [xi.zone.THE_SANCTUARY_OF_ZITAH] =
        {
            ['Holey_Horror'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mob:getLocalVar('asaDamageType') == xi.damageType.PIERCING then
                        npcUtil.giveKeyItem(player, xi.keyItem.LUMINOUS_GREEN_FRAGMENT)
                    end
                end,
            },

            ['Skeleton_Scuffler'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if mob:getLocalVar('asaDamageType') == xi.damageType.BLUNT then
                        npcUtil.giveKeyItem(player, xi.keyItem.LUMINOUS_RED_FRAGMENT)
                    end
                end,
            },

            ['Blest_Bones'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        mob:getLocalVar('asaAttackType') == xi.attackType.MAGICAL and
                        fireWindThunderLight[mob:getLocalVar('asaDamageType')]
                    then
                        npcUtil.giveKeyItem(player, xi.keyItem.LUMINOUS_BEIGE_FRAGMENT)
                    end
                end,
            },
        },
    },
}

return mission
