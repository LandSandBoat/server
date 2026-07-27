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
local behemothsDominionID = zones[xi.zone.BEHEMOTHS_DOMINION]
local capeTerigganID      = zones[xi.zone.CAPE_TERIGGAN]
local cloisterOfFrostID   = zones[xi.zone.CLOISTER_OF_FROST]
local laTheinePlateauID   = zones[xi.zone.LA_THEINE_PLATEAU]
local westernAltepaID     = zones[xi.zone.WESTERN_ALTEPA_DESERT]
local yuhtungaJungleID    = zones[xi.zone.YUHTUNGA_JUNGLE]
local sanctuaryOfZitahID  = zones[xi.zone.THE_SANCTUARY_OF_ZITAH]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE)

mission.reward =
{
    title       = xi.title.BEARER_OF_THE_EIGHT_PRAYERS,
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES },
}

local requiredFragments =
{
    xi.ki.FIRE_FRAGMENT,
    xi.ki.ICE_FRAGMENT,
    xi.ki.WIND_FRAGMENT,
    xi.ki.EARTH_FRAGMENT,
    xi.ki.LIGHTNING_FRAGMENT,
    xi.ki.WATER_FRAGMENT,
    xi.ki.LIGHT_FRAGMENT,
}

-- Note: Dark Fragment is granted on complete for ZM4 and not checked here.
local function hasAllFragments(player)
    for _, keyItemId in ipairs(requiredFragments) do
        if not player:hasKeyItem(keyItemId) then
            return false
        end
    end

    return true
end

-- A monument only answers a player who accepted its prompt and is close enough to it. After multiple captures,
-- the distance is set here at a uniform 1.92 yalms, which indicates the furthest activation range on retail.
local function canUseHeadstone(player, npc, option, keyItemId)
    if option ~= 1 then
        return false
    end

    if player:checkDistance(npc:getXPos(), player:getYPos(), npc:getZPos()) > 1.92 then
        -- This message takes the key item as its second parameter.
        player:messageSpecial(zones[player:getZoneID()].text.MUST_MOVE_CLOSER, 0, keyItemId)

        return false
    end

    return true
end

-- Retail shows the all 8 fragments message in place of the key item message on the final fragment.
local function giveFragment(player, keyItemId)
    local ID = zones[player:getZoneID()]

    player:addKeyItem(keyItemId)

    if not hasAllFragments(player) then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, keyItemId)

        return
    end

    player:messageSpecial(ID.text.FOUND_ALL_FRAGS, keyItemId)
    mission:complete(player)
end

mission.sections =
{
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

                        return mission:noAction()
                    elseif GetSystemTime() >= npc:getLocalVar('cooldown') then
                        if
                            not GetMobByID(behemothsDominionID.mob.ANCIENT_WEAPON):isSpawned() and
                            not GetMobByID(behemothsDominionID.mob.LEGENDARY_WEAPON):isSpawned()
                        then
                            return mission:progressEvent(200, xi.ki.LIGHTNING_FRAGMENT)
                        else
                            return mission:messageSpecial(behemothsDominionID.text.SOMETHING_BETTER)
                        end
                    else
                        return mission:progressEvent(201, xi.ki.LIGHTNING_FRAGMENT)
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    if not canUseHeadstone(player, npc, option, xi.ki.LIGHTNING_FRAGMENT) then
                        return
                    end

                    npc:messageText(player, behemothsDominionID.text.AIR_AROUND_YOU_CHANGED)

                    SpawnMob(behemothsDominionID.mob.ANCIENT_WEAPON):updateClaim(player)
                    SpawnMob(behemothsDominionID.mob.LEGENDARY_WEAPON):updateClaim(player)
                end,

                [201] = function(player, csid, option, npc)
                    if not canUseHeadstone(player, npc, option, xi.ki.LIGHTNING_FRAGMENT) then
                        return
                    end

                    giveFragment(player, xi.ki.LIGHTNING_FRAGMENT)
                end,
            },
        },

        [xi.zone.CAPE_TERIGGAN] =
        {
            ['Cermet_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.WIND_FRAGMENT) then
                        -- If the quest isn't completed, it's accepted by force, and we use quest trigger.
                        if player:hasCompletedQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.WANDERING_SOULS) then
                            player:messageSpecial(capeTerigganID.text.ALREADY_OBTAINED_FRAG, xi.ki.WIND_FRAGMENT)
                            return mission:noAction()
                        end
                    else
                        if GetSystemTime() >= npc:getLocalVar('cooldown') then
                            if not GetMobByID(capeTerigganID.mob.AXESARION_THE_WANDERER):isSpawned() then
                                return mission:progressEvent(200, xi.ki.WIND_FRAGMENT)
                            else
                                return mission:messageSpecial(capeTerigganID.text.SOMETHING_BETTER)
                            end
                        else
                            return mission:progressEvent(201, xi.ki.WIND_FRAGMENT) -- Gives KI. Starts quest.
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    if not canUseHeadstone(player, npc, option, xi.ki.WIND_FRAGMENT) then
                        return
                    end

                    npc:messageText(player, capeTerigganID.text.COLD_WIND_CHILLS_YOU)

                    SpawnMob(capeTerigganID.mob.AXESARION_THE_WANDERER):updateClaim(player)
                end,

                [201] = function(player, csid, option, npc)
                    if not canUseHeadstone(player, npc, option, xi.ki.WIND_FRAGMENT) then
                        return
                    end

                    player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.WANDERING_SOULS)

                    giveFragment(player, xi.ki.WIND_FRAGMENT)
                end,
            },
        },

        [xi.zone.CLOISTER_OF_FROST] =
        {
            ['Cermet_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.ICE_FRAGMENT) then
                        return mission:progressEvent(200, xi.ki.ICE_FRAGMENT)
                    elseif hasAllFragments(player) then
                        return mission:messageSpecial(cloisterOfFrostID.text.ALREADY_HAVE_ALL_FRAGS)
                    elseif player:hasKeyItem(xi.ki.ICE_FRAGMENT) then
                        player:messageSpecial(cloisterOfFrostID.text.ALREADY_OBTAINED_FRAG, xi.ki.ICE_FRAGMENT)

                        return mission:noAction()
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    if not canUseHeadstone(player, npc, option, xi.ki.ICE_FRAGMENT) then
                        return
                    end

                    giveFragment(player, xi.ki.ICE_FRAGMENT)
                end,
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Cermet_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.WATER_FRAGMENT) then
                        return mission:progressEvent(200, xi.ki.WATER_FRAGMENT)
                    elseif hasAllFragments(player) then
                        return mission:messageSpecial(laTheinePlateauID.text.ALREADY_HAVE_ALL_FRAGS)
                    elseif player:hasKeyItem(xi.ki.WATER_FRAGMENT) then
                        player:messageSpecial(laTheinePlateauID.text.ALREADY_OBTAINED_FRAG, xi.ki.WATER_FRAGMENT)

                        return mission:noAction()
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    if not canUseHeadstone(player, npc, option, xi.ki.WATER_FRAGMENT) then
                        return
                    end

                    giveFragment(player, xi.ki.WATER_FRAGMENT)
                end,
            },
        },

        [xi.zone.NORG] =
        {
            ['Gilgamesh']  = mission:event(9),
        },

        [xi.zone.THE_SANCTUARY_OF_ZITAH] =
        {
            ['Cermet_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.LIGHT_FRAGMENT) then
                         -- If the quest isn't completed, it's accepted and we use quest trigger.
                        if player:hasCompletedQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.SOUL_SEARCHING) then
                            player:messageSpecial(sanctuaryOfZitahID.text.ALREADY_OBTAINED_FRAG, xi.ki.LIGHT_FRAGMENT)
                            return mission:noAction()
                        end
                    else
                        if GetSystemTime() >= npc:getLocalVar('cooldown') then
                            if not GetMobByID(sanctuaryOfZitahID.mob.DOOMED_PILGRIMS):isSpawned() then
                                return mission:progressEvent(200, xi.ki.LIGHT_FRAGMENT)
                            else
                                return mission:messageSpecial(sanctuaryOfZitahID.text.SOMETHING_BETTER)
                            end
                        else
                            return mission:progressEvent(201, xi.ki.LIGHT_FRAGMENT) -- Gives KI. Starts quest.
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    if not canUseHeadstone(player, npc, option, xi.ki.LIGHT_FRAGMENT) then
                        return
                    end

                    npc:messageText(player, sanctuaryOfZitahID.text.AIR_HAS_SUDDENLY_CHANGED)

                    SpawnMob(sanctuaryOfZitahID.mob.DOOMED_PILGRIMS):updateClaim(player)
                end,

                [201] = function(player, csid, option, npc)
                    if not canUseHeadstone(player, npc, option, xi.ki.LIGHT_FRAGMENT) then
                        return
                    end

                    player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.SOUL_SEARCHING)

                    giveFragment(player, xi.ki.LIGHT_FRAGMENT)
                end,
            },
        },

        [xi.zone.WESTERN_ALTEPA_DESERT] =
        {
            ['Cermet_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.EARTH_FRAGMENT) then
                        return mission:progressEvent(200, xi.ki.EARTH_FRAGMENT)
                    elseif hasAllFragments(player) then
                        return mission:messageSpecial(westernAltepaID.text.ALREADY_HAVE_ALL_FRAGS)
                    elseif player:hasKeyItem(xi.ki.EARTH_FRAGMENT) then
                        player:messageSpecial(westernAltepaID.text.ALREADY_OBTAINED_FRAG, xi.ki.EARTH_FRAGMENT)

                        return mission:noAction()
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    if not canUseHeadstone(player, npc, option, xi.ki.EARTH_FRAGMENT) then
                        return
                    end

                    giveFragment(player, xi.ki.EARTH_FRAGMENT)
                end,
            },
        },

        [xi.zone.YUHTUNGA_JUNGLE] =
        {
            ['Cermet_Headstone'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.FIRE_FRAGMENT) then
                        -- If the quest isn't completed, it's accepted and we use quest trigger.
                        if player:hasCompletedQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.WRATH_OF_THE_OPO_OPOS) then
                            player:messageSpecial(yuhtungaJungleID.text.ALREADY_OBTAINED_FRAG, xi.ki.FIRE_FRAGMENT)
                            return mission:noAction()
                        end
                    else
                        if GetSystemTime() >= npc:getLocalVar('cooldown') then
                            if
                                not GetMobByID(yuhtungaJungleID.mob.TIPHA):isSpawned() and
                                not GetMobByID(yuhtungaJungleID.mob.CARTHI):isSpawned()
                            then
                                return mission:progressEvent(200, xi.ki.FIRE_FRAGMENT)
                            else
                                return mission:messageSpecial(yuhtungaJungleID.text.SOMETHING_BETTER)
                            end
                        else
                            return mission:progressEvent(201, xi.ki.FIRE_FRAGMENT) -- Gives KI. Starts quest.
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [200] = function(player, csid, option, npc)
                    if not canUseHeadstone(player, npc, option, xi.ki.FIRE_FRAGMENT) then
                        return
                    end

                    npc:messageText(player, yuhtungaJungleID.text.THE_OPO_OPOS_ATTACK)

                    SpawnMob(yuhtungaJungleID.mob.TIPHA):updateClaim(player)
                    SpawnMob(yuhtungaJungleID.mob.CARTHI):updateClaim(player)
                end,

                [201] = function(player, csid, option, npc)
                    if not canUseHeadstone(player, npc, option, xi.ki.FIRE_FRAGMENT) then
                        return
                    end

                    player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.WRATH_OF_THE_OPO_OPOS)

                    giveFragment(player, xi.ki.FIRE_FRAGMENT)
                end,
            },
        },
    },

    -- Section: Mission has been Completed
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.BEHEMOTHS_DOMINION] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(behemothsDominionID.text.ALREADY_HAVE_ALL_FRAGS):replaceDefault(),
        },

        [xi.zone.CAPE_TERIGGAN] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(capeTerigganID.text.ZILART_MONUMENT):replaceDefault(),
        },

        [xi.zone.CLOISTER_OF_FROST] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(cloisterOfFrostID.text.ALREADY_HAVE_ALL_FRAGS):replaceDefault(),
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(laTheinePlateauID.text.ALREADY_HAVE_ALL_FRAGS):replaceDefault(),
        },

        [xi.zone.THE_SANCTUARY_OF_ZITAH] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(sanctuaryOfZitahID.text.ZILART_MONUMENT):replaceDefault(),
        },

        [xi.zone.WESTERN_ALTEPA_DESERT] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(westernAltepaID.text.ALREADY_HAVE_ALL_FRAGS):replaceDefault(),
        },

        [xi.zone.YUHTUNGA_JUNGLE] =
        {
            ['Cermet_Headstone'] = mission:messageSpecial(yuhtungaJungleID.text.ZILART_MONUMENT):replaceDefault(),
        },
    },
}

return mission
