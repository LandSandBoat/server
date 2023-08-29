-----------------------------------
-- A Testing Time
-- Windurst M2-2
-----------------------------------
-- !addmission 2 4
--     Gate Guards
-- Rakoh Buuma      - !pos 106 -5 -23 241
-- Mokyokyo         - !pos -55 -8 227 238
-- Janshura-Rashura - !pos -227 -8 184 240
-- Zokima-Rokima    - !pos 0 -16 124 239
--
-- Moreno-Toeno - !pos 169 -1.25 159 238
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.A_TESTING_TIME)

mission.reward =
{
    rankPoints = 300,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 4 then
        mission:begin(player)
        player:setMissionStatus(mission.areaId, 1)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

local killCounter = function(mob, player, optParams)
    local testVar = mission:getVar(player, 'KillCount')
    mission:setVar(player, 'KillCount', testVar + 1)
end

local assessment = function(player, npc)
    local startTime     = mission:getVar(player, 'StartTime')
    local startDay      = mission:getVar(player, 'StartDay')
    local startHour     = mission:getVar(player, 'StartHour')
    local secondsPassed = os.time() - startTime
    local hoursPassed   = VanadielHour()
    local killCount     = mission:getVar(player, 'KillCount')
    local completed     = player:hasCompletedMission(mission.areaId, mission.missionId)

    -- player took too long to speak under requirements in time, so they fail mission
    if
        (not completed and secondsPassed > 3456) or
        (completed and secondsPassed > 6912)
    then
        return mission:progressEvent(202)
    end

    -- handle the events for first-time doing the mission
    if not completed and secondsPassed > 3312 then
        local event = 198

        if killCount >= 35 then
            event = 201
        elseif killCount >= 30 then
            event = 200
        elseif killCount >= 19 then
            event = 199
        end

        return mission:progressEvent(event, 0, VanadielHour(), 1, killCount)
    -- handle the events for repeating mission
    elseif completed and secondsPassed > 6768 then
        local event = 208

        if killCount >= 35 then
            event = 206
        elseif killCount >= 30 then
            event = 209
        end

        return mission:progressEvent(event, 0, VanadielHour(), 1, killCount)
    -- player hasn't waited long enough to be assessed
    else
        if VanadielDayOfTheYear() == startDay then
            hoursPassed = hoursPassed - startHour
        elseif VanadielDayOfTheYear() == startDay + 1 then
            hoursPassed = hoursPassed - startHour + 24
        else
            if completed then
                hoursPassed = (24 - startHour) + hoursPassed + 24
            else
                hoursPassed = (24 - startHour) + hoursPassed
            end
        end

        if completed then
            return mission:progressEvent(204, 0, 0, 0, 0, 0, VanadielHour(), 48 - hoursPassed, 0)
        else
            return mission:progressEvent(183, 0, VanadielHour(), 24 - hoursPassed)
        end
    end
end

local failMission = function(player, csid, option, npc)
    mission:setVar(player, 'StartDay', 0)
    mission:setVar(player, 'StartHour', 0)
    mission:setVar(player, 'StartTime', 0)
    mission:setVar(player, 'KillCount', 0)
    player:delKeyItem(xi.ki.CREATURE_COUNTER_MAGIC_DOLL)
    player:delMission(mission.areaId, mission.missionId)
end

local clearMission = function(player, csid, option, npc)
    if mission:complete(player) then
        player:delKeyItem(xi.ki.CREATURE_COUNTER_MAGIC_DOLL)
    end
end

mission.sections =
{
    -- Player is offered mission from a gate guard. Note that retail will have the
    -- player be presented with the mission selection menu, choose, accept, and then
    -- start the events below, where you accept it again.
    -- Choosing to keep the existing flow we had already.
    {
        check = function(player, currentMission)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId and
                not player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            onEventFinish =
            {
                [78] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            onEventFinish =
            {
                [93] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            onEventFinish =
            {
                [111] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            onEventFinish =
            {
                [114] = handleAcceptMission,
            },
        },
    },

    -- Mission has been accepted, these NPCs dialogue does not change during mission
    {
        check = function(player, currentMission)
            return currentMission == mission.missionId
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Janshura-Rashura'] = mission:event(133),
            ['Nine_of_Clubs']    = mission:event(134),
            ['Puo_Rhen']         = mission:event(136),
            ['Ten_of_Clubs']     = mission:event(135),
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Chawo_Shipeynyo'] = mission:event(130),
            ['Keo-Koruo']       = mission:event(128),
            ['Pakke-Pokke']     = mission:event(129),
            ['Zokima-Rokima']   = mission:event(127),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Akkeke']          = mission:event(190),
            ['Chomoro-Kyotoro'] = mission:event(195),
            ['Dagoza-Beruza']   = mission:event(178),
            ['Foi-Mui']         = mission:event(193),
            ['Fuepepe']         = mission:event(186),
            ['Kirarara']        = mission:event(188),
            ['Koko_Lihzeh']     = mission:event(191),
            ['Mashuu-Ajuu']     = mission:event(192),
            ['Mimomo']          = mission:event(196),
            ['Mokyokyo']        = mission:event(177),
            ['Paku-Nakku']      = mission:event(194),
            ['Panna-Donna']     = mission:event(179),
            ['Pechiru-Mashiru'] = mission:event(185),
            ['Rukuku']          = mission:event(189),
            ['Tauwawa']         = mission:event(187),
            ['Ten_of_Hearts']   = mission:event(180),
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Miiri-Wohri'] = mission:event(474),
            ['Rakoh_Buuma'] = mission:event(473),
            ['Sola_Jaab']   = mission:event(475),
            ['Tih_Pikeh']   = mission:event(476),
        },
    },

    -- Talk to Moreno-Toeno (inside the Aurastery) at Windurst Waters, North (L-6)
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Moreno-Toeno'] =
            {
                onTrigger = function(player, npc)
                    local completed = player:hasCompletedMission(mission.areaId, mission.missionId)

                    if not completed then
                        return mission:progressEvent(182) -- first time
                    elseif completed then
                        return mission:progressEvent(687) -- repeating
                    end
                end,
            },

            onEventFinish =
            {
                [182] = function(player, csid, option, npc)
                    if option == 2 then
                        player:setMissionStatus(mission.areaId, 2)
                        npcUtil.giveKeyItem(player, xi.ki.CREATURE_COUNTER_MAGIC_DOLL)
                        mission:setVar(player, 'StartDay', VanadielDayOfTheYear())
                        mission:setVar(player, 'StartHour', VanadielHour())
                        mission:setVar(player, 'StartTime', os.time())
                    end
                end,

                [687] = function(player, csid, option, npc)
                    if option == 2 then
                        player:setMissionStatus(mission.areaId, 2)
                        npcUtil.giveKeyItem(player, xi.ki.CREATURE_COUNTER_MAGIC_DOLL)
                        mission:setVar(player, 'StartDay', VanadielDayOfTheYear())
                        mission:setVar(player, 'StartHour', VanadielHour())
                        mission:setVar(player, 'StartTime', os.time())
                    end
                end,
            },
        },
    },

    -- Kill Tahrongi Canyon mobs if first time doing mission
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 2 and
            not player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.TAHRONGI_CANYON] =
        {
            ['Air_Elemental']         = { onMobDeath = killCounter, },
            ['Akbaba']                = { onMobDeath = killCounter, },
            ['Barghest']              = { onMobDeath = killCounter, },
            ['Canyon_Crawler']        = { onMobDeath = killCounter, },
            ['Canyon_Rarab']          = { onMobDeath = killCounter, },
            ['Earth_Elemental']       = { onMobDeath = killCounter, },
            ['Goblin_Ambusher']       = { onMobDeath = killCounter, },
            ['Goblin_Archaeologist']  = { onMobDeath = killCounter, },
            ['Goblin_Digger']         = { onMobDeath = killCounter, },
            ['Goblin_Thug']           = { onMobDeath = killCounter, },
            ['Goblin_Tinkerer']       = { onMobDeath = killCounter, },
            ['Goblin_Weaver']         = { onMobDeath = killCounter, },
            ['Grenade']               = { onMobDeath = killCounter, },
            ['Habrok']                = { onMobDeath = killCounter, },
            ['Herbage_Hunter']        = { onMobDeath = killCounter, },
            ['Killer_Bee']            = { onMobDeath = killCounter, },
            ['Poltergeist']           = { onMobDeath = killCounter, },
            ['Pygmaioi']              = { onMobDeath = killCounter, },
            ['Serpopard_Ishtar']      = { onMobDeath = killCounter, },
            ['Skeleton_Sorcerer']     = { onMobDeath = killCounter, },
            ['Skeleton_Warrior']      = { onMobDeath = killCounter, },
            ['Strolling_Sapling']     = { onMobDeath = killCounter, },
            ['Wild_Dhalmel']          = { onMobDeath = killCounter, },
            ['Yagudo_Acolyte']        = { onMobDeath = killCounter, },
            ['Yagudo_Initiate']       = { onMobDeath = killCounter, },
            ['Yagudo_Mendicant']      = { onMobDeath = killCounter, },
            ['Yagudo_Persecutor']     = { onMobDeath = killCounter, },
            ['Yagudo_Piper']          = { onMobDeath = killCounter, },
            ['Yagudo_Scribe']         = { onMobDeath = killCounter, },
            ['Yara_Ma_Yha_Who']       = { onMobDeath = killCounter, },
        },
    },

    -- Kill Buburimu Peninsula mobs if repeating mission
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 2 and
            player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.BUBURIMU_PENINSULA] =
        {
            ['Air_Elemental']         = { onMobDeath = killCounter, },
            ['Backoo']                = { onMobDeath = killCounter, },
            ['Buburimboo']            = { onMobDeath = killCounter, },
            ['Bull_Dhalmel']          = { onMobDeath = killCounter, },
            ['Carnivorous_Crawler']   = { onMobDeath = killCounter, },
            ['Ghoul']                 = { onMobDeath = killCounter, },
            ['Goblin_Ambusher']       = { onMobDeath = killCounter, },
            ['Goblin_Bounty_Hunter']  = { onMobDeath = killCounter, },
            ['Goblin_Butcher']        = { onMobDeath = killCounter, },
            ['Goblin_Gambler']        = { onMobDeath = killCounter, },
            ['Goblin_Leecher']        = { onMobDeath = killCounter, },
            ['Goblin_Mugger']         = { onMobDeath = killCounter, },
            ['Goblin_Tinkerer']       = { onMobDeath = killCounter, },
            ['Helldiver']             = { onMobDeath = killCounter, },
            ['Might_Rarab']           = { onMobDeath = killCounter, },
            ['Poison_Leech']          = { onMobDeath = killCounter, },
            ['Shoal_Pugil']           = { onMobDeath = killCounter, },
            ['Snipper']               = { onMobDeath = killCounter, },
            ['Sylvestre']             = { onMobDeath = killCounter, },
            ['Wake_Warder_Wanda']     = { onMobDeath = killCounter, },
            ['Water_Elemental']       = { onMobDeath = killCounter, },
            ['Will-o-the-Wisp']       = { onMobDeath = killCounter, },
            ['Zombie']                = { onMobDeath = killCounter, },
            ['Zu']                    = { onMobDeath = killCounter, },
        },
    },

    -- Speaking to Moreno-Toeno afterwards to be assessed.
    {
        check = function(player, currentMission, missionStatus)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Moreno-Toeno'] =
            {
                onTrigger = function(player, npc)
                    return assessment(player, npc)
                end,
            },

            onEventFinish =
            {
                [198] = failMission,
                [199] = failMission,
                [202] = failMission,
                [208] = failMission,
                [200] = clearMission,
                [201] = clearMission,
                [206] = clearMission,
                [209] = clearMission,
            },
        },
    },
}

return mission
