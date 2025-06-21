describe('Zilart Missions', function()
    local client, player

    before_each(function()
        client, player = xi.test.world:spawnPlayer()
    end)

    describe('ZM1 to ZM3', function()
        it('should complete ZM1 - The New Frontier', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_NEW_FRONTIER)
            player:setRank(6)
            assert.player(player).has.nationRank(6)

            -- After defeating the Shadow Lord and gaining rank 6, head to Norg for a cut-scene.
            client:gotoZone(xi.zone.NORG)
            client:expectEvent({ eventId = 1 })
            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.WELCOME_TNORG)
        end)

        it("should complete ZM2 - Welcome T'Norg", function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.WELCOME_TNORG)

            -- Go to L-8 and click on the "Oaken Door" to get a cutscene with Gilgamesh.
            client:gotoZone(xi.zone.NORG)
            client:gotoAndTriggerEntity('_700', { eventId = 2 }) -- Oaken Door
            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.KAZHAMS_CHIEFTAINESS)
        end)

        it("should complete ZM3 - Kazham's Chieftainess", function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.KAZHAMS_CHIEFTAINESS)

            -- Talk to Jakoh Wahcondalo at (J-9) in Kazham to obtain the Key ItemSacrificial Chamber Key,
            -- which is required to enter the deeper areas of the Temple of Uggalepih.
            client:gotoZone(xi.zone.KAZHAM)
            client:gotoAndTriggerEntity('Jakoh_Wahcondalo', { eventId = 114 })
            assert.player(player).has.ki(xi.ki.SACRIFICIAL_CHAMBER_KEY)
            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH)
        end)
    end)

    describe('ZM4 - The Temple of Uggalepih', function()
        it('should complete the Sacrificial Chamber battle', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH)
            player:addKeyItem(xi.ki.SACRIFICIAL_CHAMBER_KEY)

            -- After entering the Sacrificial Chamber, examine the heavy door to enter the Battlefield.
            client:gotoZone(xi.zone.SACRIFICIAL_CHAMBER)
            client:enterBcnmViaNpc('_4j0', xi.battlefield.id.TEMPLE_OF_UGGALEPIH)
            client:killBattlefieldMobs()
            client:expectBcnmWin()

            client:expectEvent({ eventId = 7 })
            client:expectEvent({ eventId = 8 })

            assert.player(player).no.ki(xi.ki.SACRIFICIAL_CHAMBER_KEY)
            assert.player(player).has.ki(xi.ki.DARK_FRAGMENT)
            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE)
        end)
    end)

    describe('ZM5 - Headstone Pilgrimage', function()
        before_each(function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE)
        end)

        it('should collect Water fragment', function()
            client:gotoZone(xi.zone.LA_THEINE_PLATEAU)
            client:gotoAndTriggerEntity('Cermet_Headstone', { eventId = 200, finishOption = 1 })
            assert.player(player).has.ki(xi.ki.WATER_FRAGMENT)
            client:gotoAndTriggerEntity('Cermet_Headstone')
            client:expectNotInEvent()
        end)

        it('should collect Ice fragment', function()
            client:gotoZone(xi.zone.CLOISTER_OF_FROST)
            client:gotoAndTriggerEntity('Cermet_Headstone', { eventId = 200, finishOption = 1 })
            assert.player(player).has.ki(xi.ki.ICE_FRAGMENT)
            client:gotoAndTriggerEntity('Cermet_Headstone')
            client:expectNotInEvent()
        end)

        it('should collect Earth fragment', function()
            client:gotoZone(xi.zone.WESTERN_ALTEPA_DESERT)
            client:gotoAndTriggerEntity('Cermet_Headstone', { eventId = 200, finishOption = 1 })
            assert.player(player).has.ki(xi.ki.EARTH_FRAGMENT)
            client:gotoAndTriggerEntity('Cermet_Headstone')
            client:expectNotInEvent()
        end)

        it('should collect Fire fragment by defeating Tipha and Carthi', function()
            client:gotoZone(xi.zone.YUHTUNGA_JUNGLE)
            local tipha = client:getEntity(zones[xi.zone.YUHTUNGA_JUNGLE].mob.TIPHA)
            local carthi = client:getEntity(zones[xi.zone.YUHTUNGA_JUNGLE].mob.CARTHI)
            assert(not tipha:isSpawned(), 'Tipha already spawned')
            assert(not carthi:isSpawned(), 'Carthi already spawned')

            -- Ensure repeated test runs don't prevent respawn from cooldown
            local yuhtungaHeadstone = client:getEntity('Cermet_Headstone')
            yuhtungaHeadstone:setLocalVar('cooldown', 0)

            client:gotoAndTriggerEntity(yuhtungaHeadstone, { eventId = 200, finishOption = 1 })
            assert(tipha:isSpawned(), 'Tipha did not spawn')
            assert(carthi:isSpawned(), 'Carthi did not spawn')

            client:claimAndKillMob(tipha)
            client:claimAndKillMob(carthi)

            client:gotoAndTriggerEntity(yuhtungaHeadstone, { finishOption = 1 })
            assert.player(player).has.ki(xi.ki.FIRE_FRAGMENT)
            client:expectNotInEvent()
            assert(not tipha:isSpawned(), 'Tipha spawned again')
            assert(not carthi:isSpawned(), 'Carthi spawned again')
        end)

        it('should collect Wind fragment by defeating Axesarion', function()
            client:gotoZone(xi.zone.CAPE_TERIGGAN)
            local axesarion = client:getEntity(zones[xi.zone.CAPE_TERIGGAN].mob.AXESARION_THE_WANDERER)
            assert(not axesarion:isSpawned(), 'Axesarion already spawned')

            -- Ensure repeated test runs don't prevent respawn from cooldown
            local terigganHeadstone = client:getEntity('Cermet_Headstone')
            terigganHeadstone:setLocalVar('cooldown', 0)

            client:gotoAndTriggerEntity(terigganHeadstone, { eventId = 200, finishOption = 1 })
            assert(axesarion:isSpawned(), 'Axesarion did not spawn')

            client:claimAndKillMob(axesarion)

            client:gotoAndTriggerEntity(terigganHeadstone, { eventId = 201, finishOption = 1 })
            assert.player(player).has.ki(xi.ki.WIND_FRAGMENT)
            client:expectNotInEvent()
            assert(not axesarion:isSpawned(), 'Axesarion spawned again')
        end)

        it('should collect Lightning fragment by defeating Legendary and Ancient Weapons', function()
            client:gotoZone(xi.zone.BEHEMOTHS_DOMINION)
            local legWeapon = client:getEntity(zones[xi.zone.BEHEMOTHS_DOMINION].mob.LEGENDARY_WEAPON)
            local ancWeapon = client:getEntity(zones[xi.zone.BEHEMOTHS_DOMINION].mob.ANCIENT_WEAPON)
            assert(not legWeapon:isSpawned(), 'Legendary Weapon already spawned')
            assert(not ancWeapon:isSpawned(), 'Ancient Weapon already spawned')

            -- Ensure repeated test runs don't prevent respawn from cooldown
            local bdHeadstone = client:getEntity('Cermet_Headstone')
            bdHeadstone:setLocalVar('cooldown', 0)

            client:gotoAndTriggerEntity(bdHeadstone, { eventId = 200, finishOption = 1 })
            assert(legWeapon:isSpawned(), 'Legendary Weapon did not spawn')
            assert(ancWeapon:isSpawned(), 'Ancient Weapon did not spawn')

            client:claimAndKillMob(legWeapon)
            client:claimAndKillMob(ancWeapon)

            client:gotoAndTriggerEntity(bdHeadstone, { eventId = 201, finishOption = 1 })
            assert.player(player).has.ki(xi.ki.LIGHTNING_FRAGMENT)
            client:expectNotInEvent()
            assert(not legWeapon:isSpawned(), 'Legendary Weapon spawned again')
            assert(not ancWeapon:isSpawned(), 'Ancient Weapon spawned again')
        end)

        it('should collect Light fragment by defeating Doomed Pilgrims', function()
            client:gotoZone(xi.zone.THE_SANCTUARY_OF_ZITAH)
            local pilgrim = client:getEntity(zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.DOOMED_PILGRIMS)
            assert(not pilgrim:isSpawned(), 'Doomed Pilgrem already spawned')

            -- Ensure repeated test runs don't prevent respawn from cooldown
            local zitahHeadstone = client:getEntity('Cermet_Headstone')
            zitahHeadstone:setLocalVar('cooldown', 0)

            client:gotoAndTriggerEntity(zitahHeadstone, { eventId = 200, finishOption = 1 })
            assert(pilgrim:isSpawned(), 'Doomed Pilgrem did not spawn')

            client:claimAndKillMob(pilgrim)

            client:gotoAndTriggerEntity(zitahHeadstone, { eventId = 201, finishOption = 1 })
            assert.player(player).has.ki(xi.ki.LIGHT_FRAGMENT)
            client:expectNotInEvent()
            assert(not pilgrim:isSpawned(), 'Doomed Pilgrems spawned again')
        end)

        it('should complete the mission after collecting all fragments', function()
            player:addKeyItem(xi.ki.WATER_FRAGMENT)
            player:addKeyItem(xi.ki.ICE_FRAGMENT)
            player:addKeyItem(xi.ki.FIRE_FRAGMENT)
            player:addKeyItem(xi.ki.WIND_FRAGMENT)
            player:addKeyItem(xi.ki.LIGHTNING_FRAGMENT)
            player:addKeyItem(xi.ki.LIGHT_FRAGMENT)
            player:addKeyItem(xi.ki.DARK_FRAGMENT)
            client:gotoZone(xi.zone.WESTERN_ALTEPA_DESERT)
            client:gotoAndTriggerEntity('Cermet_Headstone', { eventId = 200, finishOption = 1 })
            assert.player(player).has.ki(xi.ki.EARTH_FRAGMENT)
            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES)
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
            client:gotoZone(xi.zone.CHAMBER_OF_ORACLES)
            client:enterBcnmViaNpc(zones[xi.zone.CHAMBER_OF_ORACLES].npc.BCNM_ENTRY,
                xi.battlefield.id.THROUGH_THE_QUICKSAND_CAVES)
            client:killBattlefieldMobs()
            client:expectBcnmWin()

            -- Upon defeating the 3 NM Anticans you will be appear in another area of the Chamber of Oracles;
            -- this is the start of "ZM7 - The Chamber of Oracles".
            -- Place the fragments in the pedestals for cutscene.
            client:expectNotInEvent()
            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CHAMBER_OF_ORACLES)

            -- Place a fragment on each pedestal
            for idx, info in ipairs(pedestalsFragmentsTable) do
                assert.player(player).has.ki(info[1])
                client:gotoAndTriggerEntity(info[2])
                assert.player(player).no.ki(info[1])

                if idx ~= #pedestalsFragmentsTable then
                    -- Is not the last pedestal, so just a message is given
                    client:expectNotInEvent()
                else
                    -- Clicking the last pedestal starts cutscene
                    client:expectEvent({ eventId = 1 })
                end
            end

            assert.player(player).has.ki(xi.ki.PRISMATIC_FRAGMENT)
            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER)
        end)
    end)

    describe("ZM8 - Return to Delkfutt's Tower", function()
        it("should defeat Archduke Kam'lanaut", function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER)

            -- Go through the portal to Stellar Fulcrum. You will receive a cutscene.
            client:gotoZone(xi.zone.STELLAR_FULCRUM)
            client:expectEvent({ eventId = 0 })

            -- Fight and defeat Archduke Kam'lanaut.
            client:enterBcnmViaNpc('_4z0', xi.battlefield.id.RETURN_TO_DELKFUTTS_TOWER)
            client:killBattlefieldMobs()
            client:expectBcnmWin({ finishOption = 1 })

            -- When the battle has concluded, be prepared for a long cutscene (approx. 6 minutes).
            client:expectEvent({ eventId = 17 })
        end)
    end)

    describe('ZM9 to ZM13', function()
        it("should complete ZM9 - Ro'Maeve", function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.ROMAEVE)
            -- Next head to Norg to talk to Gilgamesh.
            client:gotoZone(xi.zone.NORG)
            client:expectNotInEvent()
            client:gotoAndTriggerEntity('_700', { eventId = 3 }) -- Oaken Door
            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_DESOLATION)
        end)

        it('should complete ZM10 - The Temple of Desolation', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_DESOLATION)

            -- Observe the gate at the other end of Hall of the Gods twice.
            client:gotoZone(xi.zone.HALL_OF_THE_GODS)
            client:expectNotInEvent()
            client:gotoAndTriggerEntity('_6z0', { eventId = 1 })
            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_HALL_OF_THE_GODS)
        end)

        it('should complete ZM11 - The Hall of the Gods', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_HALL_OF_THE_GODS)

            -- .. go back to Norg and talk to Gilgamesh.
            client:gotoZone(xi.zone.NORG)
            client:expectNotInEvent()
            client:gotoAndTriggerEntity('_700', { eventId = 169 }) -- Oaken Door
            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL)
        end)

        it('should complete ZM12 - The Mithra and the Crystal', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL)

            -- Go to Rabao and talk to Maryoh Comyujah, who's standing in front of the windmill at G-7.
            client:gotoZone(xi.zone.RABAO)
            client:expectNotInEvent()
            client:gotoAndTriggerEntity('Maryoh_Comyujah', { eventId = 81, finishOption = 1 })

            -- .. zone into Quicksand Caves.
            client:gotoZone(xi.zone.QUICKSAND_CAVES)
            -- Touch the ??? and select Yes to spawn the Ancient Vessel.
            client:gotoAndTriggerEntity('qm7', { eventId = 12, finishOption = 1 })
            assert.player(player).no.ki(xi.ki.SCRAP_OF_PAPYRUS)

            -- Kill the Ancient Vessel and inspect the ??? again to dig out the Scrap of Papyrus (key item).
            client:claimAndKillMob('Ancient_Vessel')
            client:gotoAndTriggerEntity('qm7', { eventId = 13, finishOption = 1 })
            assert.player(player).has.ki(xi.ki.SCRAP_OF_PAPYRUS)

            -- Return it to Maryoh Comyujah who will give you the Cerulean Crystal (key item).
            client:gotoZone(xi.zone.RABAO)
            client:expectNotInEvent()
            client:gotoAndTriggerEntity('Maryoh_Comyujah', { eventId = 83 })
            assert.player(player).no.ki(xi.ki.SCRAP_OF_PAPYRUS)
            assert.player(player).has.ki(xi.ki.CERULEAN_CRYSTAL)
        end)

        it('should complete ZM13 - The Gate of the Gods', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL)
            player:addKeyItem(xi.ki.CERULEAN_CRYSTAL)

            -- Head back to the Hall of the Gods and touch the sealed gate and watch the cutscenes.
            client:gotoZone(xi.zone.HALL_OF_THE_GODS)
            client:expectNotInEvent()
            client:gotoAndTriggerEntity('_6z0', { eventId = 4 })
            -- There's two Shimmering Circles, so have to pick the lower one.
            client:gotoAndTriggerEntity(17805319, { eventId = 3 })
            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_GATE_OF_THE_GODS)

            -- Note: You will also have to touch the Portal to Sky for the last CS.
            client:gotoZone(xi.zone.RUAUN_GARDENS)
            client:expectEvent({ eventId = 51 })
            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.ARK_ANGELS)
        end)
    end)

    describe('ZM14 - Ark Angels via Divine Might', function()
        it('should complete Divine Might battle', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.ARK_ANGELS)
            player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT)

            -- Take the main entrance to the Shrine of Ru'Avitau and run straight until you find an unmarked target.
            client:gotoZone(xi.zone.THE_SHRINE_OF_RUAVITAU)
            client:gotoAndTriggerEntity('blank_divine_might', { eventId = 53 })

            player:addItem(xi.item.ARK_PENTASPHERE)

            -- Go to La'Loff Amphitheater and use the Ark Pentasphere to enter a BC where you will confront and defeat all 5 Ark Angels.
            client:gotoZone(xi.zone.LALOFF_AMPHITHEATER)
            client:enterBcnmViaNpc('qm1_1', xi.battlefield.id.DIVINE_MIGHT, { xi.item.ARK_PENTASPHERE })
            client:killBattlefieldMobs()
            client:expectBcnmWin()

            assert.player(player).has.ki(xi.ki.SHARD_OF_APATHY)
            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_SEALED_SHRINE)
        end)
    end)

    describe('ZM15 to ZM17 - Final Missions', function()
        it('should complete ZM15 - The Sealed Shrine', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_SEALED_SHRINE)

            -- Now go to Norg and talk to Gilgamesh.
            client:gotoZone(xi.zone.NORG)
            client:expectNotInEvent()
            client:gotoAndTriggerEntity('_700', { eventId = 172 }) -- Oaken Door

            -- Then go to Lower Jeuno and talk to Aldo in Tenshodo HQ J-8 for a cutscene.
            client:gotoZone(xi.zone.LOWER_JEUNO)
            client:expectNotInEvent()
            client:gotoAndTriggerEntity('Aldo', { eventId = 111 })

            -- Enter Shrine of Ru'Avitau again from the (H-8) entrance for a cutscene with Lion.
            client:gotoZone(xi.zone.THE_SHRINE_OF_RUAVITAU, { x = -40, y = -2, z = -230 })
            client:expectEvent({ eventId = 51 })
            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS)
        end)

        it('should complete ZM16 - The Celestial Nexus', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS)

            client:gotoZone(xi.zone.THE_CELESTIAL_NEXUS)

            -- Upcoming CS will dump us in Hall of the Gods.
            -- TODO: Figure out how we can smartly load it on demand.
            xi.test.world:loadZone(xi.zone.HALL_OF_THE_GODS)

            client:enterBcnmViaNpc('_513', xi.battlefield.id.CELESTIAL_NEXUS)

            -- Phase 1
            local eald = client:getEntity(zones[xi.zone.THE_CELESTIAL_NEXUS].mob.EALDNARCHE)
            local exoplates = client:getEntity(zones[xi.zone.THE_CELESTIAL_NEXUS].mob.EALDNARCHE + 1)
            exoplates:setUnkillable(false)

            client:claimAndKillMob(exoplates)
            client:claimAndKillMob(eald)
            client:expectEvent({ eventId = 32004 })

            -- Phase 2
            local eald2 = client:getEntity(zones[xi.zone.THE_CELESTIAL_NEXUS].mob.EALDNARCHE + 2)
            client:claimAndKillMob(eald2)
            client:expectBcnmWin()

            -- After the final cutscene, you appear in Hall of the Gods.
            assert.equal(player:getZoneID(), xi.zone.HALL_OF_THE_GODS)

            assert.player(player).has.mission(xi.mission.log_id.ZILART, xi.mission.id.zilart.AWAKENING)
        end)

        it('should complete ZM17 - Awakening', function()
            player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.AWAKENING)

            -- Zone into Norg for a cutscene with Gilgamesh.
            client:gotoZone(xi.zone.NORG)
            client:expectEvent({ eventId = 176 })

            -- Enter the Neptune's Spire in Lower Jeuno for a cutscene with Aldo.
            client:gotoZone(xi.zone.LOWER_JEUNO)
            client:gotoAndTriggerEntity('_6tc', { eventId = 20 }) -- Door to Neptune's Spire

            -- Start of Shadows of the Departed
            -- After the conquest tally walk back into the Ducal palace for a cutscene.
            player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE)
            -- TODO: Eden had y as 0, the trigger area may need to be adjusted.
            client:gotoZone(xi.zone.RULUDE_GARDENS, { x = 0, y = 3, z = 45 })
            client:expectEvent({ eventId = 161 })
        end)
    end)
end)
