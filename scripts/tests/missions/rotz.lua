describe('Rise of the Zilart', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer()
    end)

    describe('ZM1 to ZM3', function()
        it('should complete ZM1 - The New Frontier', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_NEW_FRONTIER)
            player:setRank(6)
            player.assert:hasNationRank(6)

            -- After defeating the Shadow Lord and gaining rank 6, head to Norg for a cut-scene.
            player:gotoZone(xi.zone.NORG)
            player.events:expect({ eventId = 1 })
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.WELCOME_TNORG)
        end)

        it("should complete ZM2 - Welcome T'Norg", function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.WELCOME_TNORG)

            -- Go to L-8 and click on the "Oaken Door" to get a cutscene with Gilgamesh.
            player:gotoZone(xi.zone.NORG)
            player.entities:gotoAndTrigger('_700', { eventId = 2 }) -- Oaken Door
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.KAZHAMS_CHIEFTAINESS)
        end)

        it("should complete ZM3 - Kazham's Chieftainess", function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.KAZHAMS_CHIEFTAINESS)

            -- Talk to Jakoh Wahcondalo at (J-9) in Kazham to obtain the Key ItemSacrificial Chamber Key,
            -- which is required to enter the deeper areas of the Temple of Uggalepih.
            player:gotoZone(xi.zone.KAZHAM)
            player.entities:gotoAndTrigger('Jakoh_Wahcondalo', { eventId = 114 })
            player.assert:hasKI(xi.ki.SACRIFICIAL_CHAMBER_KEY)
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH)
        end)
    end)

    describe('ZM4 - The Temple of Uggalepih', function()
        it('should complete the Sacrificial Chamber battle', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH)
            player:addKeyItem(xi.ki.SACRIFICIAL_CHAMBER_KEY)

            -- After entering the Sacrificial Chamber, examine the heavy door to enter the Battlefield.
            player:gotoZone(xi.zone.SACRIFICIAL_CHAMBER)
            player.bcnm:enter('_4j0', xi.battlefield.id.TEMPLE_OF_UGGALEPIH)
            player.bcnm:killMobs()
            player.bcnm:expectWin()

            player.events:expect({ eventId = 7 })
            player.events:expect({ eventId = 8 })

            player.assert.no:hasKI(xi.ki.SACRIFICIAL_CHAMBER_KEY)
            player.assert:hasKI(xi.ki.DARK_FRAGMENT)
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE)
        end)
    end)

    describe('ZM5 - Headstone Pilgrimage', function()
        before_each(function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE)
        end)

        it('should collect Water fragment', function()
            player:gotoZone(xi.zone.LA_THEINE_PLATEAU)
            player.entities:gotoAndTrigger('Cermet_Headstone', { eventId = 200, finishOption = 1 })
            player.assert:hasKI(xi.ki.WATER_FRAGMENT)
            player.entities:gotoAndTrigger('Cermet_Headstone')
            player.events:expectNotInEvent()
        end)

        it('should collect Ice fragment', function()
            player:gotoZone(xi.zone.CLOISTER_OF_FROST)
            player.entities:gotoAndTrigger('Cermet_Headstone', { eventId = 200, finishOption = 1 })
            player.assert:hasKI(xi.ki.ICE_FRAGMENT)
            player.entities:gotoAndTrigger('Cermet_Headstone')
            player.events:expectNotInEvent()
        end)

        it('should collect Earth fragment', function()
            player:gotoZone(xi.zone.WESTERN_ALTEPA_DESERT)
            player.entities:gotoAndTrigger('Cermet_Headstone', { eventId = 200, finishOption = 1 })
            player.assert:hasKI(xi.ki.EARTH_FRAGMENT)
            player.entities:gotoAndTrigger('Cermet_Headstone')
            player.events:expectNotInEvent()
        end)

        it('should collect Fire fragment by defeating Tipha and Carthi', function()
            player:gotoZone(xi.zone.YUHTUNGA_JUNGLE)
            local tipha = player.entities:get(zones[xi.zone.YUHTUNGA_JUNGLE].mob.TIPHA)
            local carthi = player.entities:get(zones[xi.zone.YUHTUNGA_JUNGLE].mob.CARTHI)
            tipha.assert.no:isSpawned()
            carthi.assert.no:isSpawned()

            -- Ensure repeated test runs don't prevent respawn from cooldown
            local yuhtungaHeadstone = player.entities:get('Cermet_Headstone')
            yuhtungaHeadstone:setLocalVar('cooldown', 0)

            player.entities:gotoAndTrigger(yuhtungaHeadstone, { eventId = 200, finishOption = 1 })
            tipha.assert:isSpawned()
            carthi.assert:isSpawned()

            player:claimAndKillMob(tipha)
            player:claimAndKillMob(carthi)

            player.entities:gotoAndTrigger(yuhtungaHeadstone, { finishOption = 1 })
            player.assert:hasKI(xi.ki.FIRE_FRAGMENT)
            player.events:expectNotInEvent()
            tipha.assert.no:isSpawned()
            carthi.assert.no:isSpawned()
        end)

        it('should collect Wind fragment by defeating Axesarion', function()
            player:gotoZone(xi.zone.CAPE_TERIGGAN)
            local axesarion = player.entities:get(zones[xi.zone.CAPE_TERIGGAN].mob.AXESARION_THE_WANDERER)
            axesarion.assert.no:isSpawned()

            -- Ensure repeated test runs don't prevent respawn from cooldown
            local terigganHeadstone = player.entities:get('Cermet_Headstone')
            terigganHeadstone:setLocalVar('cooldown', 0)

            player.entities:gotoAndTrigger(terigganHeadstone, { eventId = 200, finishOption = 1 })
            axesarion.assert:isSpawned()

            player:claimAndKillMob(axesarion)

            player.entities:gotoAndTrigger(terigganHeadstone, { eventId = 201, finishOption = 1 })
            player.assert:hasKI(xi.ki.WIND_FRAGMENT)
            player.events:expectNotInEvent()
            axesarion.assert.no:isSpawned()
        end)

        it('should collect Lightning fragment by defeating Legendary and Ancient Weapons', function()
            player:gotoZone(xi.zone.BEHEMOTHS_DOMINION)
            local legWeapon = player.entities:get(zones[xi.zone.BEHEMOTHS_DOMINION].mob.LEGENDARY_WEAPON)
            local ancWeapon = player.entities:get(zones[xi.zone.BEHEMOTHS_DOMINION].mob.ANCIENT_WEAPON)
            legWeapon.assert.no:isSpawned()
            ancWeapon.assert.no:isSpawned()

            -- Ensure repeated test runs don't prevent respawn from cooldown
            local bdHeadstone = player.entities:get('Cermet_Headstone')
            bdHeadstone:setLocalVar('cooldown', 0)

            player.entities:gotoAndTrigger(bdHeadstone, { eventId = 200, finishOption = 1 })
            legWeapon.assert:isSpawned()
            ancWeapon.assert:isSpawned()

            player:claimAndKillMob(legWeapon)
            player:claimAndKillMob(ancWeapon)

            player.entities:gotoAndTrigger(bdHeadstone, { eventId = 201, finishOption = 1 })
            player.assert:hasKI(xi.ki.LIGHTNING_FRAGMENT)
            player.events:expectNotInEvent()
            legWeapon.assert.no:isSpawned()
            ancWeapon.assert.no:isSpawned()
        end)

        it('should collect Light fragment by defeating Doomed Pilgrims', function()
            player:gotoZone(xi.zone.THE_SANCTUARY_OF_ZITAH)
            local pilgrim = player.entities:get(zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.DOOMED_PILGRIMS)
            pilgrim.assert.no:isSpawned()

            -- Ensure repeated test runs don't prevent respawn from cooldown
            local zitahHeadstone = player.entities:get('Cermet_Headstone')
            zitahHeadstone:setLocalVar('cooldown', 0)

            player.entities:gotoAndTrigger(zitahHeadstone, { eventId = 200, finishOption = 1 })
            pilgrim.assert:isSpawned()

            player:claimAndKillMob(pilgrim)

            player.entities:gotoAndTrigger(zitahHeadstone, { eventId = 201, finishOption = 1 })
            player.assert:hasKI(xi.ki.LIGHT_FRAGMENT)
            player.events:expectNotInEvent()
            pilgrim.assert.no:isSpawned()
        end)

        it('Earth fragment should complete the mission after collecting all fragments', function()
            player:addKeyItem(xi.ki.WATER_FRAGMENT)
            player:addKeyItem(xi.ki.ICE_FRAGMENT)
            player:addKeyItem(xi.ki.FIRE_FRAGMENT)
            player:addKeyItem(xi.ki.WIND_FRAGMENT)
            player:addKeyItem(xi.ki.LIGHTNING_FRAGMENT)
            player:addKeyItem(xi.ki.LIGHT_FRAGMENT)
            player:addKeyItem(xi.ki.DARK_FRAGMENT)
            player:gotoZone(xi.zone.WESTERN_ALTEPA_DESERT)
            player.entities:gotoAndTrigger('Cermet_Headstone', { eventId = 200, finishOption = 1 })
            player.assert:hasKI(xi.ki.EARTH_FRAGMENT)
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES)
        end)
    end)

    describe('ZM6 and ZM7 - Chamber of Oracles', function()
        it('should complete Through the Quicksand Caves and The Chamber of Oracles', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES)
            local pedestalsFragmentsTable =
            {
                { xi.ki.FIRE_FRAGMENT,      'Pedestal_of_Fire' },
                { xi.ki.EARTH_FRAGMENT,     'Pedestal_of_Earth' },
                { xi.ki.WATER_FRAGMENT,     'Pedestal_of_Water' },
                { xi.ki.WIND_FRAGMENT,      'Pedestal_of_Wind' },
                { xi.ki.ICE_FRAGMENT,       'Pedestal_of_Ice' },
                { xi.ki.LIGHTNING_FRAGMENT, 'Pedestal_of_Lightning' },
                { xi.ki.LIGHT_FRAGMENT,     'Pedestal_of_Light' },
                { xi.ki.DARK_FRAGMENT,      'Pedestal_of_Darkness' },
            }
            for _, info in ipairs(pedestalsFragmentsTable) do
                player:addKeyItem(info[1])
            end

            -- Enter the Chamber of Oracles.
            player:gotoZone(xi.zone.CHAMBER_OF_ORACLES)
            player.bcnm:enter('SC_Entrance',
                xi.battlefield.id.THROUGH_THE_QUICKSAND_CAVES)
            player.bcnm:killMobs()
            player.bcnm:expectWin()

            -- Upon defeating the 3 NM Anticans you will be appear in another area of the Chamber of Oracles;
            -- this is the start of "ZM7 - The Chamber of Oracles".
            -- Place the fragments in the pedestals for cutscene.
            player.events:expectNotInEvent()
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CHAMBER_OF_ORACLES)

            -- Place a fragment on each pedestal
            for idx, info in ipairs(pedestalsFragmentsTable) do
                player.assert:hasKI(info[1])
                player.entities:gotoAndTrigger(info[2])
                player.assert.no:hasKI(info[1])

                if idx ~= #pedestalsFragmentsTable then
                    -- Is not the last pedestal, so just a message is given
                    player.events:expectNotInEvent()
                else
                    -- Clicking the last pedestal starts cutscene
                    player.events:expect({ eventId = 1 })
                end
            end

            player.assert:hasKI(xi.ki.PRISMATIC_FRAGMENT)
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER)
        end)
    end)

    describe("ZM8 - Return to Delkfutt's Tower", function()
        it("should defeat Archduke Kam'lanaut", function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER)

            -- Go through the portal to Stellar Fulcrum. You will receive a cutscene.
            player:gotoZone(xi.zone.STELLAR_FULCRUM)
            player.events:expect({ eventId = 0 })

            -- Fight and defeat Archduke Kam'lanaut.
            player.bcnm:enter('_4z0', xi.battlefield.id.RETURN_TO_DELKFUTTS_TOWER)
            player.bcnm:killMobs()
            player.bcnm:expectWin({ finishOption = 1 })

            -- When the battle has concluded, be prepared for a long cutscene (approx. 6 minutes).
            player.events:expect({ eventId = 17 })
        end)
    end)

    describe('ZM9 to ZM13', function()
        it("should complete ZM9 - Ro'Maeve", function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.ROMAEVE)
            -- Next head to Norg to talk to Gilgamesh.
            player:gotoZone(xi.zone.NORG)
            player.events:expectNotInEvent()
            player.entities:gotoAndTrigger('_700', { eventId = 3 }) -- Oaken Door
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_DESOLATION)
        end)

        it('should complete ZM10 - The Temple of Desolation', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_DESOLATION)

            -- Observe the gate at the other end of Hall of the Gods twice.
            player:gotoZone(xi.zone.HALL_OF_THE_GODS)
            player.events:expectNotInEvent()
            player.entities:gotoAndTrigger('_6z0', { eventId = 1 })
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_HALL_OF_THE_GODS)
        end)

        it('should complete ZM11 - The Hall of the Gods', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_HALL_OF_THE_GODS)

            -- .. go back to Norg and talk to Gilgamesh.
            player:gotoZone(xi.zone.NORG)
            player.events:expectNotInEvent()
            player.entities:gotoAndTrigger('_700', { eventId = 169 }) -- Oaken Door
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL)
        end)

        it('should complete ZM12 - The Mithra and the Crystal', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL)

            -- Go to Rabao and talk to Maryoh Comyujah, who's standing in front of the windmill at G-7.
            player:gotoZone(xi.zone.RABAO)
            player.events:expectNotInEvent()
            player.entities:gotoAndTrigger('Maryoh_Comyujah', { eventId = 81, finishOption = 1 })

            -- .. zone into Quicksand Caves.
            player:gotoZone(xi.zone.QUICKSAND_CAVES)
            -- Touch the ??? and select Yes to spawn the Ancient Vessel.
            player.entities:gotoAndTrigger('qm7', { eventId = 12, finishOption = 1 })
            player.assert.no:hasKI(xi.ki.SCRAP_OF_PAPYRUS)

            -- Kill the Ancient Vessel and inspect the ??? again to dig out the Scrap of Papyrus (key item).
            player:claimAndKillMob('Ancient_Vessel')
            player.entities:gotoAndTrigger('qm7', { eventId = 13, finishOption = 1 })
            player.assert:hasKI(xi.ki.SCRAP_OF_PAPYRUS)

            -- Return it to Maryoh Comyujah who will give you the Cerulean Crystal (key item).
            player:gotoZone(xi.zone.RABAO)
            player.events:expectNotInEvent()
            player.entities:gotoAndTrigger('Maryoh_Comyujah', { eventId = 83 })
            player.assert.no:hasKI(xi.ki.SCRAP_OF_PAPYRUS)
            player.assert:hasKI(xi.ki.CERULEAN_CRYSTAL)
        end)

        it('should complete ZM13 - The Gate of the Gods', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL)
            player:addKeyItem(xi.ki.CERULEAN_CRYSTAL)

            -- Head back to the Hall of the Gods and touch the sealed gate and watch the cutscenes.
            player:gotoZone(xi.zone.HALL_OF_THE_GODS)
            player.events:expectNotInEvent()
            player.entities:gotoAndTrigger('_6z0', { eventId = 4 })
            -- There's two Shimmering Circles, so have to pick the lower one.
            player.entities:gotoAndTrigger(17805319, { eventId = 3 })
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_GATE_OF_THE_GODS)

            -- Note: You will also have to touch the Portal to Sky for the last CS.
            player:gotoZone(xi.zone.RUAUN_GARDENS)
            player.events:expect({ eventId = 51 })
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.ARK_ANGELS)
        end)
    end)

    describe('ZM14 - Ark Angels via Divine Might', function()
        it('should complete Divine Might battle', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.ARK_ANGELS)
            player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT)

            -- Take the main entrance to the Shrine of Ru'Avitau and run straight until you find an unmarked target.
            player:gotoZone(xi.zone.THE_SHRINE_OF_RUAVITAU)
            player.entities:gotoAndTrigger('blank_divine_might', { eventId = 53 })

            player:addItem(xi.item.ARK_PENTASPHERE)

            -- Go to La'Loff Amphitheater and use the Ark Pentasphere to enter a BC where you will confront and defeat all 5 Ark Angels.
            player:gotoZone(xi.zone.LALOFF_AMPHITHEATER)
            player.bcnm:enter('qm1_1', xi.battlefield.id.DIVINE_MIGHT, { xi.item.ARK_PENTASPHERE })
            player.bcnm:killMobs()
            player.bcnm:expectWin()

            player.assert:hasKI(xi.ki.SHARD_OF_APATHY)
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_SEALED_SHRINE)
        end)
    end)

    describe('ZM15 to ZM17 - Final Missions', function()
        it('should complete ZM15 - The Sealed Shrine', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_SEALED_SHRINE)

            -- Now go to Norg and talk to Gilgamesh.
            player:gotoZone(xi.zone.NORG)
            player.events:expectNotInEvent()
            player.entities:gotoAndTrigger('_700', { eventId = 172 }) -- Oaken Door

            -- Then go to Lower Jeuno and talk to Aldo in Tenshodo HQ J-8 for a cutscene.
            player:gotoZone(xi.zone.LOWER_JEUNO)
            player.events:expectNotInEvent()
            player.entities:gotoAndTrigger('Aldo', { eventId = 111 })

            -- Enter Shrine of Ru'Avitau again from the (H-8) entrance for a cutscene with Lion.
            player:gotoZone(xi.zone.THE_SHRINE_OF_RUAVITAU, { x = -40, y = -2, z = -230 })
            player.events:expect({ eventId = 51 })
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS)
        end)

        it('should complete ZM16 - The Celestial Nexus', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS)

            player:gotoZone(xi.zone.THE_CELESTIAL_NEXUS)
            player.bcnm:enter('_513', xi.battlefield.id.CELESTIAL_NEXUS)

            -- Phase 1
            local eald = player.entities:get(zones[xi.zone.THE_CELESTIAL_NEXUS].mob.EALDNARCHE)
            local exoplates = player.entities:get(zones[xi.zone.THE_CELESTIAL_NEXUS].mob.EALDNARCHE + 1)
            exoplates:setUnkillable(false)
            eald:setUnkillable(false)

            player:claimAndKillMob(exoplates)
            player:claimAndKillMob(eald)
            player.events:expect({ eventId = 32004 })

            -- Phase 2
            local eald2 = player.entities:get(zones[xi.zone.THE_CELESTIAL_NEXUS].mob.EALDNARCHE + 2)
            player:claimAndKillMob(eald2)
            player.bcnm:expectWin()

            -- After the final cutscene, you appear in Hall of the Gods.
            player.assert:inZone(xi.zone.HALL_OF_THE_GODS)
            player.assert:hasMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.AWAKENING)
        end)

        it('should complete ZM17 - Awakening', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.AWAKENING)
            local statusBefore = player:getMissionStatus(xi.mission.log_id.ZILART)
            player:setMissionStatus(xi.mission.log_id.ZILART, 0) -- Reset mission status to 0
            local statusAfter = player:getMissionStatus(xi.mission.log_id.ZILART)
            print(string.format('[TEST DEBUG] Mission status - before reset: %d, after reset: %d',
                                statusBefore, statusAfter))

            -- Zone into Norg for a cutscene with Gilgamesh.
            player:gotoZone(xi.zone.NORG)
            player.events:expect({ eventId = 176 })

            -- Enter the Neptune's Spire in Lower Jeuno for a cutscene with Aldo.
            player:gotoZone(xi.zone.LOWER_JEUNO)
            player.entities:gotoAndTrigger('_6tc', { eventId = 20 }) -- Door to Neptune's Spire

            -- Start of Shadows of the Departed
            -- After the conquest tally walk back into the Ducal palace for a cutscene.
            player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE)
            -- TODO: Eden had y as 0, the trigger area may need to be adjusted.
            player:gotoZone(xi.zone.RULUDE_GARDENS, { x = 0, y = 3, z = 45 })
            player.events:expect({ eventId = 161 })
        end)
    end)
end)
