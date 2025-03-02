require('scripts/globals/abyssea')
require('scripts/globals/gear_sets')
require('scripts/globals/quests')
require('scripts/globals/teleports')
require('scripts/events/login_campaign')
-----------------------------------
require('scripts/quests/full_speed_ahead')
-----------------------------------

local startingRaceInfo =
{
    [xi.race.HUME_M  ] = { gear = { body = xi.item.HUME_TUNIC,        hand = xi.item.HUME_M_GLOVES,     leg = xi.item.HUME_SLACKS,       feet = xi.item.HUME_M_BOOTS       }, homeNation = xi.nation.BASTOK   },
    [xi.race.HUME_F  ] = { gear = { body = xi.item.HUME_VEST,         hand = xi.item.HUME_F_GLOVES,     leg = xi.item.HUME_PANTS,        feet = xi.item.HUME_F_BOOTS       }, homeNation = xi.nation.BASTOK   },
    [xi.race.ELVAAN_M] = { gear = { body = xi.item.ELVAAN_JERKIN,     hand = xi.item.ELVAAN_GLOVES,     leg = xi.item.ELVAAN_M_CHAUSSES, feet = xi.item.ELVAAN_M_LEDELSENS }, homeNation = xi.nation.SANDORIA },
    [xi.race.ELVAAN_F] = { gear = { body = xi.item.ELVAAN_BODICE,     hand = xi.item.ELVAAN_GAUNTLETS,  leg = xi.item.ELVAAN_F_CHAUSSES, feet = xi.item.ELVAAN_F_LEDELSENS }, homeNation = xi.nation.SANDORIA },
    [xi.race.TARU_M  ] = { gear = { body = xi.item.TARUTARU_KAFTAN,   hand = xi.item.TARUTARU_MITTS,    leg = xi.item.TARUTARU_BRACCAE,  feet = xi.item.TARUTARU_CLOMPS    }, homeNation = xi.nation.WINDURST },
    [xi.race.TARU_F  ] = { gear = { body = xi.item.TARUTARU_KAFTAN,   hand = xi.item.TARUTARU_MITTS,    leg = xi.item.TARUTARU_BRACCAE,  feet = xi.item.TARUTARU_CLOMPS    }, homeNation = xi.nation.WINDURST },
    [xi.race.MITHRA  ] = { gear = { body = xi.item.MITHRAN_SEPARATES, hand = xi.item.MITHRAN_GAUNTLETS, leg = xi.item.MITHRAN_LOINCLOTH, feet = xi.item.MITHRAN_GAITERS    }, homeNation = xi.nation.WINDURST },
    [xi.race.GALKA   ] = { gear = { body = xi.item.GALKAN_SURCOAT,    hand = xi.item.GALKAN_BRACERS,    leg = xi.item.GALKAN_BRAGUETTE,  feet = xi.item.GALKAN_SANDALS     }, homeNation = xi.nation.BASTOK   },
}

local startingNationInfo =
{
    [xi.nation.SANDORIA] = { ring = xi.item.SAN_DORIAN_RING,  map = xi.ki.MAP_OF_THE_SAN_DORIA_AREA },
    [xi.nation.BASTOK  ] = { ring = xi.item.BASTOKAN_RING,    map = xi.ki.MAP_OF_THE_BASTOK_AREA    },
    [xi.nation.WINDURST] = { ring = xi.item.WINDURSTIAN_RING, map = xi.ki.MAP_OF_THE_WINDURST_AREA  },
}

local startingJobGear =
{
    [xi.job.WAR] = { xi.item.ONION_SWORD                               },
    [xi.job.MNK] = { xi.item.WHITE_BELT                                },
    [xi.job.WHM] = { xi.item.ONION_ROD,    xi.item.SCROLL_OF_CURE_EX  },
    [xi.job.BLM] = { xi.item.ONION_STAFF,  xi.item.SCROLL_OF_STONE_EX },
    [xi.job.RDM] = { xi.item.ONION_DAGGER, xi.item.SCROLL_OF_DIA_EX   },
    [xi.job.THF] = { xi.item.ONION_KNIFE                               },
}

-----------------------------------
-- public functions
-----------------------------------
xi = xi or {}
xi.player = {}

xi.player.charCreate = function(player)
    local race       = player:getRace()
    local raceInfo   = startingRaceInfo[race]
    local nation     = player:getNation()
    local nationInfo = startingNationInfo[nation]

    -- add race-specific starting gear
    for _, v in pairs(raceInfo.gear) do
        if not player:hasItem(v) then
            player:addItem(v)
            player:equipItem(v)
        end
    end

    -- add job-specific starting gear
    for _, v in pairs(startingJobGear[player:getMainJob()]) do
        if not player:hasItem(v) then
            player:addItem(v)
        end
    end

    -- add nation-specific map
    player:addKeyItem(nationInfo.map)

    -- add job-emote Key items
    player:addKeyItem(xi.ki.JOB_GESTURE_WARRIOR)
    player:addKeyItem(xi.ki.JOB_GESTURE_MONK)
    player:addKeyItem(xi.ki.JOB_GESTURE_WHITE_MAGE)
    player:addKeyItem(xi.ki.JOB_GESTURE_BLACK_MAGE)
    player:addKeyItem(xi.ki.JOB_GESTURE_RED_MAGE)
    player:addKeyItem(xi.ki.JOB_GESTURE_THIEF)

    -- add nation- and race-specific ring
    if nation == raceInfo.homeNation and not player:hasItem(nationInfo.ring) then
        player:addItem(nationInfo.ring)
    end

    -- unlock advanced jobs
    if xi.settings.main.ADVANCED_JOB_LEVEL == 0 then
        for i = xi.job.PLD, xi.job.SCH do
            player:unlockJob(i)
        end
    end

    -- unlock subjob
    if xi.settings.main.SUBJOB_QUEST_LEVEL == 0 then
        player:unlockJob(0)
    end

    -- give all maps
    if xi.settings.main.ALL_MAPS == 1 then
        for i = xi.ki.MAP_OF_THE_SAN_DORIA_AREA, xi.ki.MAP_OF_DIO_ABDHALJS_GHELSBA do
            player:addKeyItem(i)
        end

        for i = xi.ki.MAP_OF_AL_ZAHBI, xi.ki.MAP_OF_RAKAZNAR do
            player:addKeyItem(i)
        end

        for i = xi.ki.MAP_OF_RALA_WATERWAYS_U, xi.ki.MAP_OF_RAKAZNAR_U do
            player:addKeyItem(i)
        end

        for i = xi.ki.MAP_OF_ESCHA_ZITAH, xi.ki.MAP_OF_REISENJIMA do
            player:addKeyItem(i)
        end
    end

    -- set initial level cap
    if xi.settings.main.INITIAL_LEVEL_CAP ~= 50 then
        player:setLevelCap(xi.settings.main.INITIAL_LEVEL_CAP)
    end

    -- increase starting inventory
    if xi.settings.main.START_INVENTORY > 30 then
        player:changeContainerSize(xi.inv.INVENTORY, xi.settings.main.START_INVENTORY - 30)
        player:changeContainerSize(xi.inv.MOGSATCHEL, xi.settings.main.START_INVENTORY - 30)
    end

    --[[
        For some intermittent reason m_ZoneList ends up empty on characters, which is
        possibly also why they lose key items.  When that happens, CharCreate will be run and
        they end up losing their gil to the code below.  Added a conditional to hopefully
        prevent that until the bug is fixed.  Used the if instead of addGil to prevent abuse
        on servers with very high values of START_GIL, I guess.
    --]]

    if player:getGil() < xi.settings.main.START_GIL then
        player:setGil(xi.settings.main.START_GIL)
    end

    if xi.settings.main.NEW_CHARACTER_CUTSCENE == 0 then -- Do things that would normally be done in opening cutscene.
        player:addItem(xi.item.ADVENTURER_COUPON)
        player:setHomePoint()
    end

    player:addTitle(xi.title.NEW_ADVENTURER)
    player:setCharVar('HQuest[moghouseExpo]notSeen', 1) -- needs Moghouse intro
    player:setCharVar('spokeKindlix', 1)                -- Kindlix introduction
    player:setCharVar('spokePyropox', 1)                -- Pyropox introduction
    player:setCharVar('TutorialProgress', 1)            -- Has not started tutorial
    player:setCharVar('EinherjarIntro', 1)              -- Has not seen Einherjar intro
    player:setNewPlayer(true)                           -- apply new player flag
end

-- called by core after a player logs into the server or zones
xi.player.onGameIn = function(player, firstLogin, zoning)
    if not zoning then
        -- things checked ONLY during logon go here
        if firstLogin then
            xi.player.charCreate(player)
        end
    else
        -- things checked ONLY during zone in go here
        if
            player:getLocalVar('gameLogin') == 1 and
            xi.abyssea.isInAbysseaZone(player) and
            not player:hasStatusEffect(xi.effect.VISITANT)
        then
            local zoneID = player:getZoneID()
            local ID = zones[zoneID]

            player:messageSpecial(ID.text.ABYSSEA_TIME_OFFSET + 8)
            player:setPos(unpack(xi.abyssea.exitPositions[zoneID]))
        end
    end

    -- Abyssea starting quest should be flagged when expansion is active
    if
        xi.settings.main.ENABLE_ABYSSEA == 1 and
        player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_JOURNEY_BEGINS) == xi.questStatus.QUEST_AVAILABLE
    then
        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_JOURNEY_BEGINS)
    end

    -- This is for migration safety only, and should be removed at a later date
    if
        player:hasCompletedQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_JOURNEY_BEGINS) and
        player:getTraverserEpoch() == 0
    then
        player:setTraverserEpoch()
    end

    -- apply mods from gearsets (scripts/globals/gear_sets.lua)
    xi.gear_sets.checkForGearSet(player)

    -- god mode
    if player:getCharVar('GodMode') == 1 then
        player:addStatusEffect(xi.effect.MAX_HP_BOOST, 1000, 0, 0)
        player:addStatusEffect(xi.effect.MAX_MP_BOOST, 1000, 0, 0)
        player:addStatusEffect(xi.effect.MIGHTY_STRIKES, 1, 0, 0)
        player:addStatusEffect(xi.effect.HUNDRED_FISTS, 1, 0, 0)
        player:addStatusEffect(xi.effect.CHAINSPELL, 1, 0, 0)
        player:addStatusEffect(xi.effect.PERFECT_DODGE, 1, 0, 0)
        player:addStatusEffect(xi.effect.INVINCIBLE, 1, 0, 0)
        player:addStatusEffect(xi.effect.ELEMENTAL_SFORZO, 1, 0, 0)
        player:addStatusEffect(xi.effect.MANAFONT, 1, 0, 0)
        player:addStatusEffect(xi.effect.REGAIN, 300, 0, 0)
        player:addStatusEffect(xi.effect.REFRESH, 99, 0, 0)
        player:addStatusEffect(xi.effect.REGEN, 99, 0, 0)
        player:addMod(xi.mod.RACC, 2500)
        player:addMod(xi.mod.RATT, 2500)
        player:addMod(xi.mod.ACC, 2500)
        player:addMod(xi.mod.ATT, 2500)
        player:addMod(xi.mod.MATT, 2500)
        player:addMod(xi.mod.MACC, 2500)
        player:addMod(xi.mod.RDEF, 2500)
        player:addMod(xi.mod.DEF, 2500)
        player:addMod(xi.mod.MDEF, 2500)
        player:addHP(50000)
        player:setMP(50000)
    end

    -- !immortal
    if player:getCharVar('Immortal') == 1 then
        player:setUnkillable(true)
    end

    -- !hide
    if player:getCharVar('GMHidden') == 1 then
        player:setGMHidden(true)
    end

    -- remember time player zoned in (e.g., to support zone-in delays)
    player:setLocalVar('ZoneInTime', os.time())
    player:setLocalVar('ZoningIn', 1)

    -- Slight delay to ensure player is fully logged in
    player:timer(2500, function(playerArg)
        player:setLocalVar('ZoningIn', 0)
        -- Login Campaign rewards points once daily
        xi.events.loginCampaign.onGameIn(playerArg)
    end)

    -- Enforce that gameLogin is always set to 0 once this method exits
    -- This assists with ensuring Abyssea visitant status is handled properly on logins
    player:setLocalVar('gameLogin', 0)
end

xi.player.onPlayerDeath = function(player)
end

xi.player.onPlayerLevelUp = function(player)
end

xi.player.onPlayerLevelDown = function(player)
end

xi.player.onPlayerMount = function(player)
    -- For PM3-3 The Road Forks.  This value will be checked periodically, and break
    -- the Mimeo Jewel should a player be mounted, zone, or disconnect.
    if
        player:getZoneID() == xi.zone.ATTOHWA_CHASM and
        player:hasKeyItem(xi.ki.MIMEO_JEWEL)
    then
        player:messageSpecial(zones[xi.zone.ATTOHWA_CHASM].text.MIMEO_JEWEL_OFFSET + 4, xi.ki.MIMEO_JEWEL)
        player:delKeyItem(xi.ki.MIMEO_JEWEL)
    end
end

xi.player.onPlayerEmote = function(player, emoteId)
    if
        emoteId == xi.emote.CHEER and
        player:hasStatusEffect(xi.effect.FULL_SPEED_AHEAD)
    then
        xi.fsa.onCheer(player)
    end
end

xi.player.onPlayerVolunteer = function(player, text)
end

return xi.player
