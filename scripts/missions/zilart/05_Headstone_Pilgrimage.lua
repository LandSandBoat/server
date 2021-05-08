-----------------------------------
-- Headstone Pilgrimage
-- Zilart M5
-----------------------------------
-- !addmission 3 10
-- Cermet Headstones:
-- Behemoth's Dominion   - Lightning - !pos -74 -4 -87 127
-- Cape Teriggan         - Wind      - !pos -107 -8 450 113
-- Cloister of Frost     - Ice       - !pos 566 0 606 203
-- La Theine Plateau     - Water     - !pos -170 39 -504 102
-- Sanctuary of Zi'Tah   - Light     - !pos 235 0 280 121
-- Western Altepa Desert - Earth     - !pos -108 10 -216 125
-- Yuntunga Jungle       - Fire      - !pos 491 20 301 123
-- Additional Dialogue:
-- Gilgamesh                         - !pos 122.452 -9.009 -12.052 252
-----------------------------------
require('scripts/globals/interaction/mission')
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require("scripts/globals/titles")
require('scripts/globals/zone')
-----------------------------------
local behemothsDominionID = require("scripts/zones/Behemoths_Dominion/IDs")
local capeTerigganID      = require("scripts/zones/Cape_Teriggan/IDs")
local cloisterOfFrostID   = require("scripts/zones/Cloister_of_Frost/IDs")
local laTheinePlateauID   = require("scripts/zones/La_Theine_Plateau/IDs")
local westernAltepaID     = require("scripts/zones/Western_Altepa_Desert/IDs")
local yuhtungaJungleID    = require("scripts/zones/Yuhtunga_Jungle/IDs")
local sanctuaryOfZitahID  = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES },
    title       = xi.title.BEARER_OF_THE_EIGHT_PRAYERS,
}

-- Note: Dark Fragment is granted on complete for ZM4, and not checked here
local function hasAllFragments(player)
    return
        player:hasKeyItem(xi.ki.FIRE_FRAGMENT) and
        player:hasKeyItem(xi.ki.ICE_FRAGMENT) and
        player:hasKeyItem(xi.ki.WIND_FRAGMENT) and
        player:hasKeyItem(xi.ki.EARTH_FRAGMENT) and
        player:hasKeyItem(xi.ki.LIGHTNING_FRAGMENT) and
        player:hasKeyItem(xi.ki.WATER_FRAGMENT) and
        player:hasKeyItem(xi.ki.LIGHT_FRAGMENT)
end

mission.sections =
{
    -- Section: Mission not Active or Completed
    {
        check = function(player, currentMission, missionStatus, vars)
            return not player:hasCompletedMission(mission.areaId, mission.missionId) and currentMission ~= mission.missionId
        end,

        [xi.zone.BEHEMOTHS_DOMINION] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(behemothsDominionID.text.CANNOT_REMOVE_FRAG),
        },

        [xi.zone.CAPE_TERIGGAN] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(capeTerigganID.text.CANNOT_REMOVE_FRAG),
        },

        [xi.zone.CLOISTER_OF_FROST] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(cloisterOfFrostID.text.CANNOT_REMOVE_FRAG),
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(laTheinePlateauID.text.CANNOT_REMOVE_FRAG),
        },

        [xi.zone.THE_SANCTUARY_OF_ZITAH] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(sanctuaryOfZitahID.text.CANNOT_REMOVE_FRAG),
        },

        [xi.zone.WESTERN_ALTEPA_DESERT] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(westernAltepaID.text.CANNOT_REMOVE_FRAG),
        },

        [xi.zone.YUHTUNGA_JUNGLE] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(yuhtungaJungleID.text.CANNOT_REMOVE_FRAG),
        },
    },

    -- Section: Current Mission is Active
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BEHEMOTHS_DOMINION] =
        {
            ['Cermet_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.LIGHTNING_FRAGMENT) then
                        player:messageSpecial(behemothsDominionID.text.ALREADY_OBTAINED_FRAG, xi.ki.LIGHTNING_FRAGMENT)
                    elseif os.time() >= npc:getLocalVar("cooldown") then
                        if not GetMobByID(behemothsDominionID.mob.ANCIENT_WEAPON):isSpawned() and not GetMobByID(behemothsDominionID.mob.LEGENDARY_WEAPON):isSpawned() then
                            player:startEvent(200, xi.ki.LIGHTNING_FRAGMENT)
                        else
                            player:messageSpecial(behemothsDominionID.text.SOMETHING_BETTER)
                        end
                    else
                        player:addKeyItem(xi.ki.LIGHTNING_FRAGMENT)
                        if hasAllFragments(player) then
                            player:messageSpecial(behemothsDominionID.text.FOUND_ALL_FRAGS, xi.ki.LIGHTNING_FRAGMENT)
                            mission:complete(player)
                        else
                            player:messageSpecial(behemothsDominionID.text.KEYITEM_OBTAINED, xi.ki.LIGHTNING_FRAGMENT)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    if option == 1 then
                        SpawnMob(behemothsDominionID.mob.ANCIENT_WEAPON):updateClaim(player)
                        SpawnMob(behemothsDominionID.mob.LEGENDARY_WEAPON):updateClaim(player)
                    end
                end,
            },
        },

        [xi.zone.CAPE_TERIGGAN] =
        {
            ['Cermet_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.WIND_FRAGMENT) then
                        player:messageSpecial(capeTerigganID.text.ALREADY_OBTAINED_FRAG, xi.ki.WIND_FRAGMENT)
                    elseif os.time() >= npc:getLocalVar("cooldown") then
                        if not GetMobByID(capeTerigganID.mob.AXESARION_THE_WANDERER):isSpawned() then
                            player:startEvent(200, xi.ki.WIND_FRAGMENT)
                        else
                            player:messageSpecial(capeTerigganID.text.SOMETHING_BETTER)
                        end
                    else
                        player:addKeyItem(xi.ki.WIND_FRAGMENT)
                        if hasAllFragments(player) then
                            player:messageSpecial(capeTerigganID.text.FOUND_ALL_FRAGS, xi.ki.WIND_FRAGMENT)
                            mission:complete(player)
                        else
                            player:messageSpecial(capeTerigganID.text.KEYITEM_OBTAINED, xi.ki.WIND_FRAGMENT)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    if option == 1 then
                        SpawnMob(capeTerigganID.mob.AXESARION_THE_WANDERER):updateClaim(player)
                    end
                end,
            },
        },

        [xi.zone.CLOISTER_OF_FROST] =
        {
            ['Cermet_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.ICE_FRAGMENT) then
                        player:startEvent(200, xi.ki.ICE_FRAGMENT)
                    elseif hasAllFragments(player) then
                        player:messageSpecial(cloisterOfFrostID.text.ALREADY_HAVE_ALL_FRAGS)
                    elseif player:hasKeyItem(xi.ki.ICE_FRAGMENT) then
                        player:messageSpecial(cloisterOfFrostID.text.ALREADY_OBTAINED_FRAG, xi.ki.ICE_FRAGMENT)
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    if option == 1 then
                        player:addKeyItem(xi.ki.ICE_FRAGMENT)
                        if hasAllFragments(player) then
                            player:messageSpecial(cloisterOfFrostID.text.FOUND_ALL_FRAGS, xi.ki.ICE_FRAGMENT)
                            mission:complete(player)
                        else
                            player:messageSpecial(cloisterOfFrostID.text.KEYITEM_OBTAINED, xi.ki.ICE_FRAGMENT)
                        end
                    end
                end,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Cermet_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.WATER_FRAGMENT) then
                        player:startEvent(200, xi.ki.WATER_FRAGMENT)
                    elseif hasAllFragments(player) then
                        player:messageSpecial(laTheinePlateauID.text.ALREADY_HAVE_ALL_FRAGS)
                    elseif player:hasKeyItem(xi.ki.WATER_FRAGMENT) then
                        player:messageSpecial(laTheinePlateauID.text.ALREADY_OBTAINED_FRAG, xi.ki.WATER_FRAGMENT)
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    if option == 1 then
                        player:addKeyItem(xi.ki.WATER_FRAGMENT)
                        if hasAllFragments(player) then
                            player:messageSpecial(laTheinePlateauID.text.FOUND_ALL_FRAGS, xi.ki.WATER_FRAGMENT)
                            mission:complete(player)
                        else
                            player:messageSpecial(laTheinePlateauID.text.KEYITEM_OBTAINED, xi.ki.WATER_FRAGMENT)
                        end
                    end
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] =
            {
                onTrigger = function(player, npc)
                    -- Reminder text
                    return mission:event(9)
                end,
            },
        },

        [xi.zone.THE_SANCTUARY_OF_ZITAH] =
        {
            ['Cermet_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.LIGHT_FRAGMENT) then
                        player:messageSpecial(sanctuaryOfZitahID.text.ALREADY_OBTAINED_FRAG, xi.ki.LIGHT_FRAGMENT)
                    elseif os.time() >= npc:getLocalVar("cooldown") then
                        if not GetMobByID(sanctuaryOfZitahID.mob.DOOMED_PILGRIMS):isSpawned() then
                            player:startEvent(200, xi.ki.LIGHT_FRAGMENT)
                        else
                            player:messageSpecial(sanctuaryOfZitahID.text.SOMETHING_BETTER)
                        end
                    else
                        player:addKeyItem(xi.ki.LIGHT_FRAGMENT)
                        if hasAllFragments(player) then
                            player:messageSpecial(sanctuaryOfZitahID.text.FOUND_ALL_FRAGS, xi.ki.LIGHT_FRAGMENT)
                            mission:complete(player)
                        else
                            player:messageSpecial(sanctuaryOfZitahID.text.KEYITEM_OBTAINED, xi.ki.LIGHT_FRAGMENT)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    if option == 1 then
                        SpawnMob(sanctuaryOfZitahID.mob.DOOMED_PILGRIMS):updateClaim(player)
                    end
                end,
            },
        },

        [xi.zone.WESTERN_ALTEPA_DESERT] =
        {
            ['Cermet_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.EARTH_FRAGMENT) then
                        player:startEvent(200, xi.ki.EARTH_FRAGMENT)
                    elseif hasAllFragments(player) then
                        player:messageSpecial(westernAltepaID.text.ALREADY_HAVE_ALL_FRAGS)
                    elseif player:hasKeyItem(xi.ki.EARTH_FRAGMENT) then
                        player:messageSpecial(westernAltepaID.text.ALREADY_OBTAINED_FRAG, xi.ki.EARTH_FRAGMENT)
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    if option == 1 then
                        player:addKeyItem(xi.ki.EARTH_FRAGMENT)
                        if hasAllFragments(player) then
                            player:messageSpecial(westernAltepaID.text.FOUND_ALL_FRAGS, xi.ki.EARTH_FRAGMENT)
                            mission:complete(player)
                        else
                            player:messageSpecial(westernAltepaID.text.KEYITEM_OBTAINED, xi.ki.EARTH_FRAGMENT)
                        end
                    end
                end,
            },
        },

        [xi.zone.YUHTUNGA_JUNGLE] =
        {
            ['Cermet_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.FIRE_FRAGMENT) then
                        player:messageSpecial(yuhtungaJungleID.text.ALREADY_OBTAINED_FRAG, xi.ki.FIRE_FRAGMENT)
                    elseif os.time() >= npc:getLocalVar("cooldown") then
                        if not GetMobByID(yuhtungaJungleID.mob.TIPHA):isSpawned() and not GetMobByID(yuhtungaJungleID.mob.CARTHI):isSpawned() then
                            player:startEvent(200, xi.ki.FIRE_FRAGMENT)
                        else
                            player:messageSpecial(yuhtungaJungleID.text.SOMETHING_BETTER)
                        end
                    else
                        player:addKeyItem(xi.ki.FIRE_FRAGMENT)
                        if hasAllFragments(player) then
                            player:messageSpecial(yuhtungaJungleID.text.FOUND_ALL_FRAGS, xi.ki.FIRE_FRAGMENT)
                            mission:complete(player)
                        else
                            player:messageSpecial(yuhtungaJungleID.text.KEYITEM_OBTAINED, xi.ki.FIRE_FRAGMENT)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    if option == 1 then
                        SpawnMob(yuhtungaJungleID.mob.TIPHA):updateClaim(player)
                        SpawnMob(yuhtungaJungleID.mob.CARTHI):updateClaim(player)
                    end
                end,
            },
        },
    },

    -- Section: Mission has been Completed
    {
        check = function(player, currentMission, missionStatus, vars)
            -- Note: This is triggered after completing the active section as well, need to find a workaround
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.BEHEMOTHS_DOMINION] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(behemothsDominionID.text.ZILART_MONUMENT),
        },

        [xi.zone.CAPE_TERIGGAN] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(capeTerigganID.text.ZILART_MONUMENT),
        },

        [xi.zone.CLOISTER_OF_FROST] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(cloisterOfFrostID.text.ZILART_MONUMENT),
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(laTheinePlateauID.text.ZILART_MONUMENT),
        },

        [xi.zone.THE_SANCTUARY_OF_ZITAH] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(sanctuaryOfZitahID.text.ZILART_MONUMENT),
        },

        [xi.zone.WESTERN_ALTEPA_DESERT] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(westernAltepaID.text.ZILART_MONUMENT),
        },

        [xi.zone.YUHTUNGA_JUNGLE] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(yuhtungaJungleID.text.ZILART_MONUMENT),
        },
    },
}

return mission
