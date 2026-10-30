local packetReader = require('scripts.tests.helpers.packet_reader')
local gustavID     = zones[xi.zone.GUSTAV_TUNNEL]

describe('ASA M6 - Enemy of the Empire II', function()
    ---@type CClientEntityPair
    local player

    -- Mob ticks run on the steady clock, the fight schedule on Earth time. Move both.
    local function advance(seconds)
        local minutes = VanadielHour() * 60 + VanadielMinute() + math.ceil(seconds / 2.4)
        xi.test.world:setVanaTime(math.floor(minutes / 60) % 24, minutes % 60)
        xi.test.world:skipTime(seconds)
    end

    local function agents()
        return
        {
            player.entities:get(gustavID.mob.RENFRED),
            player.entities:get(gustavID.mob.GORATTZ),
            player.entities:get(gustavID.mob.BOMPUPU),
        }
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 99, zone = xi.zone.GUSTAV_TUNNEL })
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_II)
        player:addKeyItem(xi.keyItem.BLACK_BOOK)
    end)

    after_each(function()
        -- A fight left running would refuse the next case's Outcropping.
        local outcropping = player.entities:get(gustavID.npc.OUTCROPPING)
        xi.confrontation.lookup[xi.confrontation.getKey(outcropping)] = nil
        for _, agent in ipairs(agents()) do
            for offset = 0, 3 do
                DespawnMob(agent:getID() + offset)
            end
        end

        outcropping:setLocalVar('agentFightOwner', 0)

        -- A despawn fades out over three seconds.
        xi.test.world:skipTime(4)
    end)

    it('takes the black book and calls the agents in, out of reach', function()
        player.entities:gotoAndTrigger('Outcropping', { eventId = 15, finishOption = 1 })

        player.assert.no:hasKI(xi.keyItem.BLACK_BOOK)
        player.assert:hasEffect(xi.effect.CONFRONTATION)
        player.assert:hasEffect(xi.effect.LEVEL_RESTRICTION)
        for _, agent in ipairs(agents()) do
            assert(agent:isSpawned(), string.format('Expected %s to be up', agent:getName()))
            assert(agent:getUntargetable(), string.format('Expected %s to be out of reach', agent:getName()))
        end
    end)

    it('refuses the Outcropping while the fight is on', function()
        player.entities:gotoAndTrigger('Outcropping', { eventId = 15, finishOption = 1 })
        player.packets:clear()

        player.entities:gotoAndTrigger('Outcropping')
        player.events:expectNotInEvent()
        assert(packetReader.saidMessage(player, gustavID.text.NOT_THE_TIME_FOR_THAT), 'Expected the Outcropping to refuse')
    end)

    it('activates the agents once eight shadows have gone down', function()
        player.entities:gotoAndTrigger('Outcropping', { eventId = 15, finishOption = 1 })
        local renfred = player.entities:get(gustavID.mob.RENFRED)
        local clone   = player.entities:get(gustavID.mob.RENFRED + 1)

        advance(20)
        assert(clone:isSpawned(), 'Expected the first shadow within twenty seconds')
        assert(clone:getUnkillable(), 'Expected the shadow to be unkillable')

        -- Three seconds pinned, then a three second fade out.
        player.entities:get(gustavID.npc.OUTCROPPING):setLocalVar('agentCloneDowns', 7)
        clone:setHP(1)
        advance(3)
        advance(5)
        advance(4)

        assert(not clone:isSpawned(), 'Expected the pinned shadow to vanish')
        assert(not renfred:getUntargetable(), 'Expected the agents to join the fight')
    end)

    it('rewards the killers and completes at the Outcropping', function()
        player.entities:gotoAndTrigger('Outcropping', { eventId = 15, finishOption = 1 })
        for _, agent in ipairs(agents()) do
            agent:setUntargetable(false)
            player:claimAndKillMob(agent)
        end

        player.assert:hasKI(xi.keyItem.CACTUAR_KEY)
        player.assert.no:hasEffect(xi.effect.CONFRONTATION)
        player.assert.no:hasEffect(xi.effect.LEVEL_RESTRICTION)

        player.entities:gotoAndTrigger('Outcropping', { eventId = 14 })
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_SUBTERFUGE)
    end)

    it('sends the agents away when time runs out', function()
        player.entities:gotoAndTrigger('Outcropping', { eventId = 15, finishOption = 1 })

        -- The agents' own tick notices the time, then they fade out over three seconds.
        xi.test.world:skipVanaDays(1)
        xi.test.world:skipTime(5)
        xi.test.world:skipTime(4)

        for _, agent in ipairs(agents()) do
            assert(not agent:isSpawned(), string.format('Expected %s to leave', agent:getName()))
        end

        player.assert.no:hasEffect(xi.effect.CONFRONTATION)
    end)

    it('hints at the footprints after the mission without a black book', function()
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_SUBTERFUGE)
        player:delKeyItem(xi.keyItem.BLACK_BOOK)
        player.packets:clear()

        player.entities:gotoAndTrigger('Outcropping')
        player.events:expectNotInEvent()
        assert(packetReader.saidMessage(player, gustavID.text.RESTLESS_FOOTPRINTS), 'Expected the footprints message')
    end)

    it('repeats the fight after the mission for another black book', function()
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_SUBTERFUGE)

        player.entities:gotoAndTrigger('Outcropping', { eventId = 15, finishOption = 1 })
        player.assert.no:hasKI(xi.keyItem.BLACK_BOOK)
        assert(player.entities:get(gustavID.mob.RENFRED):isSpawned(), 'Expected the agents to come back')
    end)
end)
