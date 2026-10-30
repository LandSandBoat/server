local fullMoonFountainID = zones[xi.zone.FULL_MOON_FOUNTAIN]

describe('ASA M10 - Battaru Royale', function()
    ---@type CClientEntityPair
    local player

    local saps =
    {
        xi.keyItem.FIRE_SAP_CRYSTAL,
        xi.keyItem.WATER_SAP_CRYSTAL,
        xi.keyItem.WIND_SAP_CRYSTAL,
        xi.keyItem.EARTH_SAP_CRYSTAL,
        xi.keyItem.LIGHTNING_SAP_CRYSTAL,
        xi.keyItem.ICE_SAP_CRYSTAL,
        xi.keyItem.LIGHT_SAP_CRYSTAL,
        xi.keyItem.DARK_SAP_CRYSTAL,
    }

    -- The win event comes on the battlefield tick after the last kill.
    local function win()
        player.bcnm:killMobs()
        xi.test.world:skipTime(2)
        player.bcnm:expectWin()
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 99, zone = xi.zone.FULL_MOON_FOUNTAIN })
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.BATTARU_ROYALE)
        for _, sap in ipairs(saps) do
            player:addKeyItem(sap)
        end
    end)

    it('takes every sap on entry', function()
        player.bcnm:enter('MS_Entrance', xi.battlefield.id.BATTARU_ROYALE)

        for _, sap in ipairs(saps) do
            player.assert.no:hasKI(sap)
        end
    end)

    it('does not open without a sap', function()
        for _, sap in ipairs(saps) do
            player:delKeyItem(sap)
        end

        player.entities:gotoAndTrigger('MS_Entrance')
        player.events:expectNotInEvent()
        assert(not player:getBattlefield(), 'Expected no battlefield without a sap')
    end)

    it('gives the Chocobo key and completes the mission on a win', function()
        player.bcnm:enter('MS_Entrance', xi.battlefield.id.BATTARU_ROYALE)
        win()

        player.assert:hasKI(xi.keyItem.CHOCOBO_KEY)
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.ROMANCING_THE_CLONE)
    end)

    it('can be repeated after the mission', function()
        player:completeMission(xi.mission.log_id.ASA, xi.mission.id.asa.BATTARU_ROYALE)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.ROMANCING_THE_CLONE)

        player.bcnm:enter('MS_Entrance', xi.battlefield.id.BATTARU_ROYALE)
        win()

        player.assert:hasKI(xi.keyItem.CHOCOBO_KEY)
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.ROMANCING_THE_CLONE)
    end)

    it('has a clone call its avatar once below 75%', function()
        player.bcnm:enter('MS_Entrance', xi.battlefield.id.BATTARU_ROYALE)

        -- Each area holds eight clones, each followed by its avatar slot.
        local clone = player.entities:get(fullMoonFountainID.mob.CLONE_OF_FLAMES + (player:getBattlefield():getArea() - 1) * 16)
        clone:updateEnmity(player)
        clone:setHP(math.floor(clone:getMaxHP() * 0.7))
        for _ = 1, 5 do
            xi.test.world:skipTime(2)
        end

        -- Astral Flow calls the avatar in the slot after the clone.
        assert(player.entities:get(clone:getID() + 1):isSpawned(), 'Expected the avatar beside the clone')

        win()
    end)
end)
