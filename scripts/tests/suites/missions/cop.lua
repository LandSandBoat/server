---@type TestSuite
local suite = {}

suite['Ancient Flames Beckon'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_FLAMES_BECKON)

    -- # COP 0
    -- zone into Lower Delkfutts Tower for a series of CS's
    client:gotoZone(xi.zone.QUFIM_ISLAND)
    client:gotoZone(xi.zone.LOWER_DELKFUTTS_TOWER)
    client:expectEvent({ eventId = 22 })
    client:expectEvent({ eventId = 36 })
    client:expectEvent({ eventId = 37 })
    client:expectEvent({ eventId = 38 })
    client:expectEvent({ eventId = 39 })
    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_RITES_OF_LIFE)
end

suite['the Rites of Life'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_RITES_OF_LIFE)
    -- # COP 1
    -- Zone into Upper Jueno for a CS
    client:gotoZone(xi.zone.UPPER_JEUNO)
    client:expectEvent({ eventId = 2 })

    -- trigger Monberaux for a series of CS's complete quest and get KI
    client:gotoAndTriggerEntity('Monberaux', { eventId = 10 })
    client:expectEvent({ eventId = 206 })
    client:expectEvent({ eventId = 207 })
    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.BELOW_THE_ARKS)
    assert.player(player).has.ki(xi.ki.MYSTERIOUS_AMULET, true)
end

suite['Below the Arks - Holla'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.BELOW_THE_ARKS)

    -- trigger Pherimociel to goto next Prog
    client:gotoZone(xi.zone.UPPER_JEUNO)
    client:gotoAndTriggerEntity('Monberaux', { eventId = 9 })

    client:gotoZone(xi.zone.RULUDE_GARDENS)
    client:gotoAndTriggerEntity('High_Wind', { eventId = 33 })
    client:gotoAndTriggerEntity('Rainhard', { eventId = 34 })
    client:gotoAndTriggerEntity('Pherimociel', { eventId = 24 })

    -- optional dialog
    client:gotoAndTriggerEntity('Pherimociel', { eventId = 25 })

    -- entering hall of transference -> Promy Holla
    client:gotoZone(xi.zone.HALL_OF_TRANSFERENCE)
    client:gotoAndTriggerEntity('_0e3', { eventId = 160 })
    -- Is ported to promyvion after event.

    assert(player:getZoneID() == xi.zone.PROMYVION_HOLLA)
    -- 1st time entering gets a CS
    client:expectEvent({ eventId = 50 })

    -- Spire of Holla, trigger and enter BCNM, winning grants next mission
    client:gotoZone(xi.zone.SPIRE_OF_HOLLA)
    client:enterBcnmViaNpc('_0h0', xi.battlefield.id.ANCIENT_FLAMES_BECKON_HOLLA)
    client:killBattlefieldMobs()
    player:setLocalVar('belowTheArks', 1)
    client:expectBcnmWin({ finishOption = 2 })
    assert.player(player).has.ki(xi.ki.LIGHT_OF_HOLLA)
    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS)
end

suite['The Mothercrystals'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS)
    player:addKeyItem(xi.ki.LIGHT_OF_HOLLA)
    player:setVar('M[6][3]Prog', 1) -- set at end of last mission

    client:gotoZone(xi.zone.RULUDE_GARDENS)
    client:gotoAndTriggerEntity('Chapi_Galepilai', { eventId = 11 })

    -- entering next promy
    client:gotoZone(xi.zone.KONSCHTAT_HIGHLANDS)
    client:gotoAndTriggerEntity('Shattered_Telepoint')
    client:expectEvent({ eventId = 912 })

    -- CS on entering promy
    client:gotoZone(xi.zone.HALL_OF_TRANSFERENCE)
    client:gotoZone(xi.zone.PROMYVION_DEM)
    client:expectEvent({ eventId = 51 })

    -- Fight at BCNM
    client:gotoZone(xi.zone.SPIRE_OF_DEM)
    client:enterBcnmViaNpc('_0j0', xi.battlefield.id.ANCIENT_FLAMES_BECKON_DEM)
    client:killBattlefieldMobs()
    client:expectBcnmWin({ finishOption = 2 })
    assert.player(player).has.ki(xi.ki.LIGHT_OF_DEM)

    -- going to next promy, cs inside hall of transference
    client:gotoZone(xi.zone.TAHRONGI_CANYON)
    client:gotoAndTriggerEntity('Shattered_Telepoint', { eventId = 913, finishOption = 0 })

    client:gotoZone(xi.zone.HALL_OF_TRANSFERENCE)
    -- event upon entering hall
    client:expectEvent({ eventId = 155 })

    -- Player is automatically zoned at the end of last event.
    assert(player:getZoneID() == xi.zone.PROMYVION_MEA)
    -- Event upon entering promy
    client:expectEvent({ eventId = 52 })

    -- enter and beat BCNM
    client:gotoZone(xi.zone.SPIRE_OF_MEA)
    client:enterBcnmViaNpc('_0l0', xi.battlefield.id.ANCIENT_FLAMES_BECKON_MEA)
    client:killBattlefieldMobs()
    client:expectBcnmWin({ finishOption = 2 })
    assert.player(player).has.ki(xi.ki.LIGHT_OF_MEA, true)

    -- check if mission completes
    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.AN_INVITATION_WEST)

    -- Mission complete check if new teleports work
    -- zone in cs
    client:gotoZone(xi.zone.LUFAISE_MEADOWS)
    client:gotoAndTriggerEntity('Swirling_Vortex')
    client:expectEvent({ eventId = 100 })

    client:gotoZone(xi.zone.MISAREAUX_COAST)
    client:gotoAndTriggerEntity('Swirling_Vortex')
    client:expectEvent({ eventId = 554 })

    client:gotoZone(xi.zone.QUFIM_ISLAND)
    client:gotoAndTriggerEntity('Swirling_Vortex')
    client:expectEvent({ eventId = 300 })

    client:gotoZone(xi.zone.VALKURM_DUNES)
    client:gotoAndTriggerEntity('Swirling_Vortex')
    client:expectEvent({ eventId = 12 })
end

suite['An Invitiation West'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.AN_INVITATION_WEST)
    player:addKeyItem(xi.ki.MYSTERIOUS_AMULET)

    -- zone in and lose amulet
    client:gotoZone(xi.zone.LUFAISE_MEADOWS)
    client:expectEvent({ eventId = 110 })
    assert.player(player).no.ki(xi.ki.MYSTERIOUS_AMULET)

    -- zone in to gain next mission
    client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
    client:expectEvent({ eventId = 101 })

    -- check if mission completes
    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LOST_CITY)
end

suite['The Lost City'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LOST_CITY)

    client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
    client:gotoAndTriggerEntity('Despachiaire')
    client:expectEvent({ eventId = 102 })

    client:gotoAndTriggerEntity('Liphatte')
    client:expectEvent({ eventId = 301 })

    client:gotoAndTriggerEntity('Justinius')
    client:expectEvent({ eventId = 360 })

    client:gotoAndTriggerEntity('_0q1')
    client:expectEvent({ eventId = 103 })

    -- check if mission completes
    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.DISTANT_BELIEFS)
end

suite['Distant Beliefs'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DISTANT_BELIEFS)

    client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
    client:gotoAndTriggerEntity('Justinius')
    client:expectEvent({ eventId = 123 })
    client:gotoAndTriggerEntity('_0q1')
    client:expectEvent({ eventId = 502 })

    client:gotoZone(xi.zone.PHOMIUNA_AQUEDUCTS)
    xi.test.world:skipTime(900)
    xi.test.world:tick()
    client:claimAndKillMob(ID.mob.MINOTOUR)

    client:gotoAndTriggerEntity(ID.npc.WOODEN_LADDER)
    client:expectEvent({ eventId = 35 })

    client:gotoAndTriggerEntity('_0r5')
    client:expectEvent({ eventId = 36 })

    client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
    client:gotoAndTriggerEntity('Justinius')
    client:expectEvent({ eventId = 113 })

    -- check if mission completes
    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.AN_ETERNAL_MELODY)
end

suite['An Eternal Melody'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.AN_ETERNAL_MELODY)

    client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
    client:gotoAndTriggerEntity('Calengeard')
    client:expectEvent({ eventId = 395 })
    client:gotoAndTriggerEntity('Reaugettie')
    client:expectEvent({ eventId = 292 })
    client:gotoAndTriggerEntity('Justinius')
    client:expectEvent({ eventId = 125 })
    client:gotoAndTriggerEntity('_0qa')
    client:expectEvent({ eventId = 104 })
    assert.player(player).has.ki(xi.ki.MYSTERIOUS_AMULET, true)

    client:gotoZone(xi.zone.MISAREAUX_COAST)
    client:gotoAndTriggerEntity('_0p0')
    client:expectEvent({ eventId = 5 })

    client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD, { x = -5, y = -24, z = 18 })
    xi.test.world:skipTime(1)
    xi.test.world:tick()
    client:expectEvent({ eventId = 105 })

    -- check if mission completes
    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)
end

suite['Ancient Vows'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    local ID = zones[xi.zone.MONARCH_LINN]

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)

    client:gotoZone(xi.zone.MISAREAUX_COAST)
    client:gotoAndTriggerEntity('_0p2')
    client:expectEvent({ eventId = 6 })

    client:gotoZone(xi.zone.RiverneSite_A01)
    client:expectEvent({ eventId = 100 })

    client:gotoZone(xi.zone.MONARCH_LINN)
    client:enterBcnmViaNpc(ID.npc.BCNM_ENTRY, xi.battlefield.id.ANCIENT_VOWS)
    client:killBattlefieldMobs()
    client:expectBcnmWin({ finishOption = 2 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.A_TRANSIENT_DREAM)

    client:expectEvent({ eventId = 906 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING)
end

suite['The Call of the Wyrmking'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING)

    client:gotoZone(xi.zone.PORT_BASTOK, { x = -100, y = 0, z = -10 })
    xi.test.world:skipTime(1)
    xi.test.world:tick()
    client:expectEvent({ eventId = 305 })

    client:gotoZone(xi.zone.METALWORKS)
    client:gotoAndTriggerEntity('Cid')
    client:expectEvent({ eventId = 845 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN)
end

suite['A Vessel Without a Captain'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN)

    client:gotoZone(xi.zone.LOWER_JEUNO)
    client:gotoAndTriggerEntity('_6tc')
    client:expectEvent({ eventId = 86 })

    client:gotoZone(xi.zone.RULUDE_GARDENS)
    client:gotoAndTriggerEntity('Auchefort')
    client:expectEvent({ eventId = 6 })
    client:gotoAndTriggerEntity('Pherimociel')
    client:expectEvent({ eventId = 26 })

    client:gotoZone(xi.zone.RULUDE_GARDENS, { x = 0, y = 0, z = 45 })
    xi.test.world:skipTime(1)
    xi.test.world:tick()
    client:expectEvent({ eventId = 65 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ROAD_FORKS)
end

suite['The Road Forks'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    local carpenterID = zones[xi.zone.CARPENTERS_LANDING]
    local chasmID = zones[xi.zone.ATTOHWA_CHASM]

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ROAD_FORKS)
    player:setVar('M[6][28]Path1', 1)
    player:setVar('M[6][28]Path2', 1)

    -- 1st Path
    client:gotoZone(xi.zone.NORTHERN_SAN_DORIA)
    xi.test.world:tick()
    client:expectEvent({ event = 14 })
    client:gotoAndTriggerEntity('Arnau')
    client:expectEvent({ eventId = 51 })
    client:gotoAndTriggerEntity('Chasalvige')
    client:expectEvent({ eventId = 38 })

    client:gotoZone(xi.zone.CARPENTERS_LANDING)
    client:gotoAndTriggerEntity('Guilloud')
    xi.test.world:tick()
    local ivy = client:getEntity(carpenterID.mob.OVERGROWN_IVY)
    assert.is_not_nil(ivy)
    assert(ivy:isSpawned())

    client:claimAndKillMob(ivy)
    xi.test.world:tick()

    client:gotoAndTriggerEntity('Guilloud')
    client:expectEvent({ event = 0 })

    client:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
    client:gotoAndTriggerEntity('Hinaree')
    client:expectEvent({ event = 23 })
    client:gotoAndTriggerEntity('Hinaree')
    client:expectEvent({ event = 24 })

    -- 2nd Path
    client:gotoZone(xi.zone.WINDURST_WATERS)
    xi.test.world:tick()
    client:expectEvent({ event = 871 })
    client:gotoAndTriggerEntity('Ohbiru-Dohbiru')
    client:expectEvent({ event = 872 })

    client:gotoZone(xi.zone.WINDURST_WALLS)
    client:gotoAndTriggerEntity('Yoran-Oran')
    client:expectEvent({ event = 469 })

    client:gotoZone(xi.zone.WINDURST_WATERS)
    client:gotoAndTriggerEntity('Kyume-Romeh', { event = 873 })
    client:gotoAndTriggerEntity('Honoi-Gomoi', { event = 874 })
    assert.player(player).has.ki(xi.ki.CRACKED_MIMEO_MIRROR, true)

    client:gotoZone(xi.zone.WINDURST_WALLS)
    client:gotoAndTriggerEntity('Yoran-Oran', { eventId = 470 })
    assert.player(player).has.ki(xi.ki.CRACKED_MIMEO_MIRROR, false)

    client:gotoZone(xi.zone.ATTOHWA_CHASM)
    client:gotoAndTriggerEntity('Loose_Sand')
    xi.test.world:tick()
    local mob2 = client:getEntity(chasmID.mob.LIOUMERE)
    assert(mob2:isSpawned())

    client:claimAndKillMob(mob2)
    xi.test.world:tick()

    client:gotoAndTriggerEntity('Loose_Sand')
    assert.player(player).has.ki(xi.ki.MIMEO_JEWEL)

    client:gotoAndTriggerEntity('Cradle_of_Rebirth')
    client:expectEvent({ event = 2 })
    assert.player(player).no.ki(xi.ki.MIMEO_JEWEL)
    assert.player(player).has.ki(xi.ki.MIMEO_FEATHER)
    assert.player(player).has.ki(xi.ki.SECOND_MIMEO_FEATHER)
    assert.player(player).has.ki(xi.ki.THIRD_MIMEO_FEATHER)

    client:gotoZone(xi.zone.WINDURST_WALLS)
    client:gotoAndTriggerEntity('Yoran-Oran')
    client:expectEvent({ event = 471 })
    assert.player(player).no.ki(xi.ki.MIMEO_FEATHER, false)
    assert.player(player).no.ki(xi.ki.SECOND_MIMEO_FEATHER, false)
    assert.player(player).no.ki(xi.ki.THIRD_MIMEO_FEATHER, false)

    client:gotoZone(xi.zone.PORT_WINDURST)
    client:gotoAndTriggerEntity('Yujuju')
    client:expectEvent({ event = 592 })

    client:gotoZone(xi.zone.WINDURST_WATERS)
    client:gotoAndTriggerEntity('Tosuka-Porika')
    client:expectEvent({ event = 875 })

    client:gotoZone(xi.zone.WINDURST_WALLS)
    client:gotoAndTriggerEntity('Yoran-Oran')
    client:expectEvent({ event = 472 })

    client:gotoZone(xi.zone.METALWORKS)
    client:gotoAndTriggerEntity('Cid')
    client:expectEvent({ event = 847 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.TENDING_AGED_WOUNDS)
end

suite['Tending Aged Wounds'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.TENDING_AGED_WOUNDS)

    client:gotoZone(xi.zone.LOWER_JEUNO)
    xi.test.world:tick()
    client:expectEvent({ event = 70 })

    client:gotoAndTriggerEntity('_6tc')
    client:expectEvent({ event = 22 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED)

    client:expectEvent({ event = 10 })
end

suite['Darkness Named'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    local ID = zones[xi.zone.THE_SHROUDED_MAW]

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED)

    client:gotoZone(xi.zone.UPPER_JEUNO)
    client:gotoAndTriggerEntity('Monberaux')
    client:expectEvent({ event = 82 })

    client:gotoZone(xi.zone.LOWER_JEUNO)
    client:gotoAndTriggerEntity('Ghebi_Damomohe')
    client:expectEvent({ event = 54 })
    client:gotoAndTriggerEntity('Ghebi_Damomohe')
    client:expectEvent({ event = 53 })

    player:addItem(xi.item.GRAY_CHIP)
    client:tradeNpc('Ghebi_Damomohe', { xi.item.GRAY_CHIP }, { eventId = 52 })
    assert.player(player).has.ki(xi.ki.PSOXJA_PASS, true)

    client:gotoZone(xi.zone.THE_SHROUDED_MAW)
    xi.test.world:tick()
    client:expectEvent({ event = 2 })

    client:enterBcnmViaNpc(ID.npc.BCNM_ENTRY, xi.battlefield.id.DARKNESS_NAMED)
    client:killBattlefieldMobs()
    client:expectBcnmWin({ finishOption = 2 })

    client:gotoZone(xi.zone.UPPER_JEUNO)
    client:gotoAndTriggerEntity('Monberaux')
    client:expectEvent({ event = 75 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.SHELTERING_DOUBT)
end

suite['Sheltering Doubt'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.SHELTERING_DOUBT)

    client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
    xi.test.world:tick()
    client:expectEvent({ event = 107 })

    client:gotoAndTriggerEntity('Justinius')
    client:expectEvent({ event = 129 })

    client:gotoAndTriggerEntity('Despachiaire')
    client:expectEvent({ event = 108 })

    client:gotoAndTriggerEntity('Justinius')
    client:expectEvent({ event = 109 })

    client:gotoZone(xi.zone.MISAREAUX_COAST)
    client:gotoAndTriggerEntity('_0p0')
    client:expectEvent({ event = 7 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SAVAGE)
end

suite['The Savage'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    local ID = zones[xi.zone.MONARCH_LINN]

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SAVAGE)

    client:gotoZone(xi.zone.MISAREAUX_COAST)
    client:gotoAndTriggerEntity('_0p2', { eventId = 8, finishOption = 1 })

    client:gotoZone(xi.zone.RIVERNE_SITE_B01)

    client:gotoZone(xi.zone.MONARCH_LINN)
    client:enterBcnmViaNpc(ID.npc.BCNM_ENTRY, xi.battlefield.id.SAVAGE)
    client:killBattlefieldMobs()
    client:expectBcnmWin({ finishOption = 2 })

    client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
    client:gotoAndTriggerEntity('Justinius', { eventId = 110 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SECRETS_OF_WORSHIP)
end

suite['The Secrets of Worship'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    local ID = zones[xi.zone.SACRARIUM]

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SECRETS_OF_WORSHIP)

    client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
    client:gotoAndTriggerEntity('_0qa', { eventId = 111 })

    client:gotoZone(xi.zone.MISAREAUX_COAST)
    client:gotoAndTriggerEntity('_0p8', { eventId = 9, finishOption = 1 })

    client:gotoZone(xi.zone.SACRARIUM)
    client:gotoAndTriggerEntity('_0s8', { eventId = 6 })
    SetServerVariable('Old_Prof_Spawn_Location', 3)

    client:gotoAndTriggerEntity('qm3')
    xi.test.world:tick()
    local professor = client:getEntity(ID.mob.OLD_PROFESSOR_MARISELLE)
    assert.is_not_nil(professor)
    assert(professor:isSpawned())

    client:claimAndKillMob(professor)
    xi.test.world:tick()
    client:gotoAndTriggerEntity('qm3')
    assert.player(player).has.ki(xi.ki.RELIQUIARIUM_KEY)

    client:gotoAndTriggerEntity('_0s8', { eventId = 5 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.SLANDEROUS_UTTERINGS)
end

suite['Slanderous Utterings'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.SLANDEROUS_UTTERINGS)

    client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD, { x = 106, y = -40, z = -80 })
    xi.test.world:skipTime(1)
    xi.test.world:tick()
    client:expectEvent({ eventId = 112 })

    client:gotoZone(xi.zone.SEALIONS_DEN)
    client:gotoAndTriggerEntity('_0w0', { eventId = 13 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR)
end

suite['The Enduring Tumult of War'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    local ID = zones[xi.zone.PSOXJA]

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR)

    client:gotoZone(xi.zone.PORT_BASTOK)
    xi.test.world:skipTime(1)
    xi.test.world:tick()
    client:expectEvent({ eventId = 306 })

    client:gotoZone(xi.zone.METALWORKS)
    client:gotoAndTriggerEntity('Cid', { eventId = 849 })
    client:gotoAndTriggerEntity('Cid', { eventId = 863 })

    client:gotoZone(xi.zone.PSOXJA, { x = -300, y = 0, z = 0 })
    xi.test.world:skipTime(1)
    xi.test.world:tick()
    client:expectEvent({ eventId = 1 })

    client:gotoAndTriggerEntity('_i98')
    local golem = client:getEntity(ID.mob.NUNYUNUWI)
    assert(golem:isSpawned())

    client:claimAndKillMob(golem)

    client:gotoAndTriggerEntity('_i99', { eventId = 2 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.DESIRES_OF_EMPTINESS)
    assert.player(player).has.ki(xi.ki.LIGHT_OF_VAHZL)

    client:expectEvent({ eventId = 50 })
end

suite['Desires of Emptiness'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    local ID = zones[xi.zone.PROMYVION_VAHZL]

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DESIRES_OF_EMPTINESS)

    client:gotoZone(xi.zone.PROMYVION_VAHZL)
    xi.test.world:skipTime(1)
    xi.test.world:tick()
    client:expectEvent({ eventId = 50 })

    client:gotoAndTriggerEntity('_0mc')
    local propagator = client:getEntity(ID.mob.PROPAGATOR)
    assert(propagator:isSpawned())
    client:claimAndKillMob(propagator)
    client:gotoAndTriggerEntity('_0mc', { eventId = 51 })

    client:gotoAndTriggerEntity('_0md')
    local policitor = client:getEntity(ID.mob.SOLICITOR)
    assert(policitor:isSpawned())
    client:claimAndKillMob(policitor)
    client:gotoAndTriggerEntity('_0md', { eventId = 52 })

    client:gotoAndTriggerEntity('_0m0')
    local ponderer = client:getEntity(ID.mob.PONDERER)
    assert(ponderer:isSpawned())
    client:claimAndKillMob(ponderer)
    client:gotoAndTriggerEntity('_0m0', { eventId = 53 })

    client:gotoZone(xi.zone.SPIRE_OF_VAHZL)
    xi.test.world:tick()
    client:expectEvent({ eventId = 20 })

    client:enterBcnmViaNpc('_0n0', xi.battlefield.id.DESIRES_OF_EMPTINESS)
    client:killBattlefieldMobs()
    xi.test.world:skipTime(15)
    xi.test.world:tick()
    client:expectBcnmWin({ finishOption = 2 })
    -- player is sent to Beaucedine Glacier at end of event
    xi.test.world:skipTime(1)
    xi.test.world:tick()
    client:expectEvent({ eventId = 206 })

    client:gotoZone(xi.zone.METALWORKS)
    client:gotoAndTriggerEntity('Cid', { eventId = 850 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS)
end

suite['Three Paths'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    local upperID = zones[xi.zone.LOWER_DELKFUTTS_TOWER]
    local bearclawID = zones[xi.zone.BEARCLAW_PINNACLE]

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS)

    -- Louverance's Path
    client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
    client:gotoAndTriggerEntity('Despachiaire', { eventId = 118 })

    client:gotoZone(xi.zone.WINDURST_WOODS)
    client:gotoAndTriggerEntity('Perih_Vashai', { eventId = 686 })

    client:gotoZone(xi.zone.BIBIKI_BAY)
    client:gotoAndTriggerEntity('Warmachine', { eventId = 33 })

    client:gotoZone(xi.zone.WINDURST_WALLS)
    client:gotoAndTriggerEntity('Yoran-Oran', { eventId = 481 })

    client:gotoZone(xi.zone.OLDTON_MOVALPOLOS)
    xi.test.world:tick()
    client:expectEvent({ eventId = 1 })

    client:gotoZone(xi.zone.MINE_SHAFT_2716)
    client:enterBcnmViaNpc('_0d0', xi.battlefield.id.CENTURY_OF_HARDSHIP)
    client:killBattlefieldMobs()
    client:expectBcnmWin({ finishOption = 2 })

    client:gotoZone(xi.zone.METALWORKS)
    client:gotoAndTriggerEntity('Cid', { eventId = 852 })

    client:gotoZone(xi.zone.OLDTON_MOVALPOLOS)
    client:gotoAndTriggerEntity('Tarnotik', { eventId = 34 })

    player:addItem(xi.item.GOLD_KEY)
    client:gotoZone(xi.zone.MINE_SHAFT_2716)
    client:tradeNpc('_0d0', { xi.item.GOLD_KEY }, { eventId = 3 })

    client:gotoZone(xi.zone.METALWORKS)
    client:gotoAndTriggerEntity('Cid', { eventId = 853 })

    -- Tenzen's Path
    client:gotoZone(xi.zone.LA_THEINE_PLATEAU)
    client:gotoAndTriggerEntity('qm3', { eventId = 203 })

    client:gotoZone(xi.zone.PSOXJA)
    client:gotoAndTriggerEntity('_09g', { eventId = 3 })

    client:gotoZone(xi.zone.UPPER_JEUNO)
    client:gotoAndTriggerEntity('Monberaux', { eventId = 74 })

    client:gotoZone(xi.zone.RULUDE_GARDENS)
    client:gotoAndTriggerEntity('Pherimociel', { eventId = 58 })

    client:gotoZone(xi.zone.UPPER_JEUNO)
    client:gotoAndTriggerEntity('Monberaux', { eventId = 6 })

    client:gotoZone(xi.zone.BATALLIA_DOWNS)
    client:gotoAndTriggerEntity('qm4', { eventId = 0 })
    client:gotoAndTriggerEntity('qm4')
    assert.player(player).has.ki(xi.ki.DELKFUTT_RECOGNITION_DEVICE, true)

    client:gotoZone(xi.zone.LOWER_DELKFUTTS_TOWER)
    client:gotoAndTriggerEntity('_545')
    local idol = client:getEntity(upperID.mob.DISASTER_IDOL)
    assert(idol:isSpawned())
    client:claimAndKillMob(idol)
    xi.test.world:tick()
    client:gotoAndTriggerEntity('_545', { eventId = 25 })
    assert.player(player).has.ki(xi.ki.DELKFUTT_RECOGNITION_DEVICE, false)

    client:gotoZone(xi.zone.PSOXJA, { x = 220, y = -8, z = -282 })
    xi.test.world:tick()
    client:expectEvent({ eventId = 4 })

    client:gotoAndTriggerEntity('_09h', { eventId = 5 })

    client:gotoZone(xi.zone.METALWORKS)
    client:gotoAndTriggerEntity('Cid', { eventId = 854 })

    -- Ulmia's Path
    client:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
    client:gotoAndTriggerEntity('Hinaree', { eventId = 22 })

    client:gotoZone(xi.zone.PORT_SAN_DORIA)
    xi.test.world:tick()
    client:expectEvent({ eventId = 4 })

    client:gotoZone(xi.zone.NORTHERN_SAN_DORIA)
    client:gotoAndTriggerEntity('Chasalvige', { eventId = 762 })

    client:gotoZone(xi.zone.WINDURST_WATERS)
    client:gotoAndTriggerEntity('Kerutoto', { eventId = 876 })

    client:gotoZone(xi.zone.WINDURST_WALLS)
    client:gotoAndTriggerEntity('Yoran-Oran', { eventId = 473 })

    client:gotoZone(xi.zone.BONEYARD_GULLY)
    client:enterBcnmViaNpc('_081', xi.battlefield.id.HEAD_WIND)
    client:killBattlefieldMobs()
    client:expectBcnmWin({ finishOption = 2 })

    client:gotoZone(xi.zone.BEARCLAW_PINNACLE)
    client:enterBcnmViaNpc(bearclawID.npc.PILLAR_1, xi.battlefield.id.FLAMES_FOR_THE_DEAD)
    client:killBattlefieldMobs()
    client:expectBcnmWin({ finishOption = 2 })

    client:gotoZone(xi.zone.METALWORKS)
    client:gotoAndTriggerEntity('Cid', { eventId = 855 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG)
end

suite['For Whom the Verse is Sung'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG)

    client:gotoZone(xi.zone.RULUDE_GARDENS)
    client:gotoAndTriggerEntity('Pherimociel', { eventId = 10046 })

    client:gotoZone(xi.zone.UPPER_JEUNO)
    client:gotoAndTriggerEntity('_6s1', { eventId = 10011 })

    client:gotoZone(xi.zone.RULUDE_GARDENS)
    xi.test.world:tick()
    client:expectEvent({ eventId = 10047 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.A_PLACE_TO_RETURN)
end

suite['A Place to Return'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    local ID = zones[xi.zone.MISAREAUX_COAST]
    local mob1 = client:getEntity(ID.mob.PM6_2_MOB_OFFSET)
    local mob2 = client:getEntity(ID.mob.PM6_2_MOB_OFFSET + 1)
    local mob3 = client:getEntity(ID.mob.PM6_2_MOB_OFFSET + 2)

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.A_PLACE_TO_RETURN)

    client:gotoZone(xi.zone.RULUDE_GARDENS, { x = 0, y = 0, z = 45 })
    xi.test.world:tick()
    xi.test.world:skipTime(2)
    client:expectEvent({ eventId = 10048 })

    client:gotoZone(xi.zone.MISAREAUX_COAST)
    client:gotoAndTriggerEntity('_0p0')
    assert(mob1:isSpawned())
    client:claimAndKillMob(mob1)
    assert(mob2:isSpawned())
    client:claimAndKillMob(mob2)
    assert(mob3:isSpawned())
    client:claimAndKillMob(mob3)
    xi.test.world:tick()

    client:gotoAndTriggerEntity('_0p0', { eventId = 10 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS)
end

suite['More Questions Than Answers'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS)

    client:gotoZone(xi.zone.RULUDE_GARDENS)
    client:gotoAndTriggerEntity('Pherimociel', { eventId = 10049 })

    client:gotoAndTriggerEntity('_6r9', { eventId = 10050 })

    client:gotoZone(xi.zone.SELBINA)
    client:gotoAndTriggerEntity('Mathilde', { eventId = 10005 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.ONE_TO_BE_FEARED)
end

suite['One to be Feared'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.ONE_TO_BE_FEARED)

    client:gotoZone(xi.zone.SELBINA)
    client:gotoAndTriggerEntity('Mathilde', { eventId = 173 })
    client:gotoAndTriggerEntity('Mathilde', { eventId = 174 })

    client:gotoZone(xi.zone.METALWORKS)
    client:gotoAndTriggerEntity('Cid', { eventId = 856 })

    client:gotoZone(xi.zone.SEALIONS_DEN)
    client:expectEvent({ eventId = 15 })

    client:gotoAndTriggerEntity('_0w0', { eventId = 31 })

    client:enterBcnmViaNpc('_0w0', xi.battlefield.id.ONE_TO_BE_FEARED)
    client:gotoAndTriggerEntity('Airship_Door', { eventId = 32003, finishOption = 100 })
    client:expectEvent({ eventId = 0 })

    client:killBattlefieldMobs()         -- Kill mammets
    client:expectEvent({ eventId = 10 }) -- Move outside battlfield

    -- Click door to enter next phase
    client:gotoAndTriggerEntity('Airship_Door', { eventId = 32003, finishOption = 100 })
    client:expectEvent({ eventId = 1 })
    client:killBattlefieldMobs()         -- Kill Omega
    client:expectEvent({ eventId = 11 }) -- Move outside battlfield again

    -- Click door to enter next phase
    client:gotoAndTriggerEntity('Airship_Door', { eventId = 32003, finishOption = 100 })
    client:expectEvent({ eventId = 2 })

    client:killBattlefieldMobs() -- Kill Ultima
    client:expectBcnmWin({ finishOption = 2 })

    client:expectEvent({ eventId = 33 })

    assert(player:getZoneID() == xi.zone.LUFAISE_MEADOWS)
    client:expectEvent({ eventId = 111 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.CHAINS_AND_BONDS)
end

suite['Chains and Bonds'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.CHAINS_AND_BONDS)

    client:gotoZone(xi.zone.LUFAISE_MEADOWS)
    xi.test.world:tick()
    client:expectEvent({ eventId = 111 })

    client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
    xi.test.world:tick()
    xi.test.world:skipTime(2)
    client:expectEvent({ eventId = 114 })
    client:gotoAndTriggerEntity('_0q1', { eventId = 116 })

    client:gotoZone(xi.zone.SEALIONS_DEN)
    xi.test.world:tick()
    client:expectEvent({ eventId = 14 })

    client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
    client:gotoAndTriggerEntity('_0qa', { eventId = 115 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.FLAMES_IN_THE_DARKNESS)
end

suite['Flames in the Darkness'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.FLAMES_IN_THE_DARKNESS)

    client:gotoZone(xi.zone.MISAREAUX_COAST)
    client:gotoAndTriggerEntity('_0p2', { eventId = 12 })

    client:gotoZone(xi.zone.SEALIONS_DEN)
    client:gotoAndTriggerEntity('Sueleen', { eventId = 16 })

    client:gotoZone(xi.zone.RULUDE_GARDENS, { x = 0, y = 0, z = 45 })
    xi.test.world:skipTime(1)
    xi.test.world:tick()
    client:expectEvent({ eventId = 10051 })

    client:gotoZone(xi.zone.UPPER_JEUNO)
    client:gotoAndTriggerEntity('_6s1', { eventId = 10012 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN)
end

suite['Fire in the Eyes of Men'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN)

    client:gotoZone(xi.zone.MINE_SHAFT_2716)
    client:gotoAndTriggerEntity('_0d0', { eventId = 4 })

    client:gotoZone(xi.zone.METALWORKS)
    client:gotoAndTriggerEntity('Cid', { eventId = 857 })

    xi.test.world:skipTime(86405)
    xi.test.world:tick()

    client:gotoAndTriggerEntity('Cid', { eventId = 890 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.CALM_BEFORE_THE_STORM)
end

suite['Calm Before the Storm'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    local coastID        = zones[xi.zone.MISAREAUX_COAST]
    local landingID      = zones[xi.zone.CARPENTERS_LANDING]
    local bayID          = zones[xi.zone.BIBIKI_BAY]

    local boggelmann     = client:getEntity(coastID.mob.BOGGELMANN)
    local crypton        = client:getEntity(landingID.mob.CRYPTONBERRY_EXECUTOR)
    local dalham         = client:getEntity(bayID.mob.DALHAM)

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.CALM_BEFORE_THE_STORM)

    client:gotoZone(xi.zone.MISAREAUX_COAST)
    client:gotoAndTriggerEntity('_0p4')
    assert(boggelmann:isSpawned())
    client:claimAndKillMob(boggelmann)
    client:gotoAndTriggerEntity('_0p4', { eventId = 13 })
    assert.player(player).has.ki(xi.ki.VESSEL_OF_LIGHT)

    client:gotoZone(xi.zone.CARPENTERS_LANDING)
    client:gotoAndTriggerEntity('qm8')
    assert(crypton:isSpawned())
    client:claimAndKillMob(crypton)
    player:setVar('Cryptonberry_Assassins-1_KILL', 1)
    player:setVar('Cryptonberry_Assassins-2_KILL', 1)
    player:setVar('Cryptonberry_Assassins-3_KILL', 1)
    client:gotoAndTriggerEntity('qm8', { eventId = 37 })

    client:gotoZone(xi.zone.BIBIKI_BAY)
    client:gotoAndTriggerEntity('qm4')
    assert(dalham:isSpawned())
    client:claimAndKillMob(dalham)
    client:gotoAndTriggerEntity('qm4', { eventId = 41 })

    client:gotoZone(xi.zone.METALWORKS)
    client:gotoAndTriggerEntity('Cid', { eventId = 891 })
    client:gotoAndTriggerEntity('Cid', { eventId = 892 })
    assert.player(player).has.ki(xi.ki.LETTERS_FROM_ULMIA_AND_PRISHE, true)

    client:gotoZone(xi.zone.SEALIONS_DEN)
    client:gotoAndTriggerEntity('Sueleen', { eventId = 17 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIOR_S_PATH)
end

suite['The Warriors Path'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIOR_S_PATH)

    client:gotoZone(xi.zone.SEALIONS_DEN)
    client:gotoAndTriggerEntity('_0w0', { eventId = 32 })

    client:enterBcnmViaNpc('_0w0', xi.battlefield.id.WARRIORS_PATH)
    client:killBattlefieldMobs()
    client:expectBcnmWin({ finishOption = 2 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.GARDEN_OF_ANTIQUITY)
end

suite['Garden of Antiquity'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    local ID = zones[xi.zone.ALTAIEU]

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.GARDEN_OF_ANTIQUITY)

    client:gotoZone(xi.zone.ALTAIEU)
    xi.test.world:tick()
    client:expectEvent({ eventId = 1 })
    client:gotoAndTriggerEntity('_0x0', { eventId = 164 })

    local southMob1 = client:getEntity(ID.mob.AERNS_TOWER_SOUTH)
    local southMob2 = client:getEntity(ID.mob.AERNS_TOWER_SOUTH + 1)
    local southMob3 = client:getEntity(ID.mob.AERNS_TOWER_SOUTH + 2)
    client:gotoAndTriggerEntity('_0x1')
    assert(southMob1:isSpawned())
    assert(southMob2:isSpawned())
    assert(southMob3:isSpawned())
    client:claimAndKillMob(southMob1)
    client:claimAndKillMob(southMob2)
    client:claimAndKillMob(southMob3)
    client:gotoAndTriggerEntity('_0x1', { eventId = 161 })

    local westMob1 = client:getEntity(ID.mob.AERNS_TOWER_WEST)
    local westMob2 = client:getEntity(ID.mob.AERNS_TOWER_WEST + 1)
    local westMob3 = client:getEntity(ID.mob.AERNS_TOWER_WEST + 2)
    client:gotoAndTriggerEntity('_0x2')
    assert(westMob1:isSpawned())
    assert(westMob2:isSpawned())
    assert(westMob3:isSpawned())
    client:claimAndKillMob(westMob1)
    client:claimAndKillMob(westMob2)
    client:claimAndKillMob(westMob3)
    client:gotoAndTriggerEntity('_0x2', { eventId = 162 })

    local eastMob1 = client:getEntity(ID.mob.AERNS_TOWER_EAST)
    local eastMob2 = client:getEntity(ID.mob.AERNS_TOWER_EAST + 1)
    local eastMob3 = client:getEntity(ID.mob.AERNS_TOWER_EAST + 2)
    client:gotoAndTriggerEntity('_0x3')
    assert(eastMob1:isSpawned())
    assert(eastMob2:isSpawned())
    assert(eastMob3:isSpawned())
    client:claimAndKillMob(eastMob1)
    client:claimAndKillMob(eastMob2)
    client:claimAndKillMob(eastMob3)
    client:gotoAndTriggerEntity('_0x3', { eventId = 163 })

    client:gotoAndTriggerEntity('_0x0', { eventId = 100 })

    client:gotoZone(xi.zone.GRAND_PALACE_OF_HUXZOI)
    xi.test.world:tick()
    client:gotoAndTriggerEntity('_iya', { eventId = 1 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED)
end

suite['A Fate Decided'] = function(world)
    local client, player = xi.test.world:spawnPlayer()
    local ID = zones[xi.zone.GRAND_PALACE_OF_HUXZOI]

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED)

    client:gotoZone(xi.zone.GRAND_PALACE_OF_HUXZOI)
    client:gotoAndTriggerEntity('_iyb', { eventId = 2 })

    client:gotoAndTriggerEntity('_iyq')
    local mob = client:getEntity(ID.mob.IXGHRAH)
    assert.is_not_nil(mob)
    assert(mob:isSpawned())
    client:claimAndKillMob(mob)
    client:gotoAndTriggerEntity('_iyq', { eventId = 3 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL)
end

suite['When Angels Fall'] = function(world)
    local client, player = xi.test.world:spawnPlayer()

    -- setup mission
    player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL)
    player:addKeyItem(xi.ki.BRAND_OF_DAWN)
    player:addKeyItem(xi.ki.BRAND_OF_TWILIGHT)

    client:gotoZone(xi.zone.THE_GARDEN_OF_RUHMET)
    xi.test.world:tick()
    client:expectEvent({ eventId = 201 })
    assert.player(player).has.ki(xi.ki.MYSTERIOUS_AMULET)

    client:gotoAndTriggerEntity('_iz2', { eventId = 202 })

    player:setVar('M[6][91]Prog', 3)

    client:gotoAndTriggerEntity('_0z0', { eventId = 203 })

    client:enterBcnmViaNpc('_0z0', xi.battlefield.id.WHEN_ANGELS_FALL)
    client:killBattlefieldMobs()
    client:expectBcnmWin({ finishOption = 2 })

    client:gotoAndTriggerEntity('_0zt', { eventId = 204 })

    assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
end

return suite
