local packetReader = require('scripts.tests.helpers.packet_reader')
local romaeveID    = zones[xi.zone.ROMAEVE]

describe('ASA M8 - Shantotto in Chains', function()
    ---@type CClientEntityPair
    local player

    local fragments =
    {
        xi.keyItem.LUMINOUS_RED_FRAGMENT,
        xi.keyItem.LUMINOUS_BEIGE_FRAGMENT,
        xi.keyItem.LUMINOUS_GREEN_FRAGMENT,
        xi.keyItem.LUMINOUS_YELLOW_FRAGMENT,
        xi.keyItem.LUMINOUS_PURPLE_FRAGMENT,
        xi.keyItem.LUMINOUS_BLUE_FRAGMENT,
    }

    -- claimAndKillMob deals typeless damage, so the killing blow is dealt by hand.
    local function killWith(mob, attackType, damageType)
        mob:addEnmity(player, 10, 10)
        mob:updateClaim(player)
        mob:takeDamage(mob:getHP(), player, attackType, damageType)
        xi.test.world:tickEntity(mob)
        xi.test.world:skipTime(1)
        xi.test.world:tickEntity(mob)
        xi.test.world:tick()
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 99 })

        -- Skips the Rhapsodies of Vana'diel cutscene on entering a city.
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONANCE)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.SHANTOTTO_IN_CHAINS)
    end)

    it('has Aldo repeat the task', function()
        player:gotoZone(xi.zone.LOWER_JEUNO)
        if player:isInEvent() then
            player.events:finish()
        end

        player.entities:gotoAndTrigger('Aldo', { eventId = 10102 })

        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.SHANTOTTO_IN_CHAINS)
    end)

    describe('the Ensorcelled Door', function()
        before_each(function()
            player:gotoZone(xi.zone.ROMAEVE)
        end)

        it('stays locked without the six fragments', function()
            for i = 1, 5 do
                player:addKeyItem(fragments[i])
            end

            player.packets:clear()
            player.entities:gotoAndTrigger('Ensorcelled_Door')
            player.events:expectNotInEvent()
            assert(packetReader.saidMessage(player, romaeveID.text.DOOR_IS_LOCKED), 'Expected the locked message')
            assert(packetReader.saidMessage(player, romaeveID.text.HEXAGONAL_DEPRESSION), 'Expected the depression message')
        end)

        it('opens for the six fragments and takes them', function()
            for _, fragment in ipairs(fragments) do
                player:addKeyItem(fragment)
            end

            player.entities:gotoAndTrigger('Ensorcelled_Door', { eventId = 71 })
            player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.FOUNTAIN_OF_TROUBLE)
            for _, fragment in ipairs(fragments) do
                player.assert.no:hasKI(fragment)
            end
        end)
    end)

    describe("Ro'Maeve fragment mobs", function()
        before_each(function()
            player:gotoZone(xi.zone.ROMAEVE)
        end)

        it('drop the yellow fragment for a ranged killing blow on a Steely Weapon', function()
            local weapon = player.entities:get(romaeveID.mob.STEELY_WEAPON[1])
            weapon.assert:isSpawned()

            killWith(weapon, xi.attackType.RANGED, xi.damageType.PIERCING)
            player.assert:hasKI(xi.keyItem.LUMINOUS_YELLOW_FRAGMENT)
        end)

        it('drop nothing for a melee killing blow on a Steely Weapon', function()
            local weapon = player.entities:get(romaeveID.mob.STEELY_WEAPON[2])
            weapon.assert:isSpawned()

            killWith(weapon, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
            player.assert.no:hasKI(xi.keyItem.LUMINOUS_YELLOW_FRAGMENT)
        end)

        it('drop the purple fragment for a slashing killing blow on a Fired Urn', function()
            local urn = player.entities:get(romaeveID.mob.FIRED_URN[1])
            urn.assert:isSpawned()

            killWith(urn, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
            player.assert:hasKI(xi.keyItem.LUMINOUS_PURPLE_FRAGMENT)
        end)

        it('drop the blue fragment for ice magic on a Lode Golem', function()
            local golem = player.entities:get(romaeveID.mob.LODE_GOLEM[1])
            golem.assert:isSpawned()

            killWith(golem, xi.attackType.MAGICAL, xi.damageType.ICE)
            player.assert:hasKI(xi.keyItem.LUMINOUS_BLUE_FRAGMENT)
        end)

        it('drop nothing once the mission has moved on', function()
            player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.FOUNTAIN_OF_TROUBLE)
            local urn = player.entities:get(romaeveID.mob.FIRED_URN[2])
            urn.assert:isSpawned()

            killWith(urn, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
            player.assert.no:hasKI(xi.keyItem.LUMINOUS_PURPLE_FRAGMENT)
        end)
    end)

    describe("Zi'Tah fragment mobs", function()
        -- Their spawn window opens at 17:00. The respawn is cut short so the next spawn wave brings the mob up.
        local function nightfall(mob)
            xi.test.world:setVanaTime(17, 0)
            mob:setRespawnTime(1)
            xi.test.world:tick(xi.tick.SPAWN)
        end

        before_each(function()
            player:gotoZone(xi.zone.THE_SANCTUARY_OF_ZITAH)
        end)

        it('are up at night and gone by day', function()
            local horror = player.entities:get('Holey_Horror')

            nightfall(horror)
            horror.assert:isSpawned()

            xi.test.world:setVanaTime(7, 0)
            xi.test.world:tick(xi.tick.VANA_HOUR)

            -- A despawn fades the mob out over three seconds.
            for _ = 1, 5 do
                xi.test.world:skipTime(1)
                xi.test.world:tickEntity(horror)
            end

            horror.assert.no:isSpawned()

            horror:setRespawnTime(1)
            xi.test.world:tick(xi.tick.SPAWN)
            horror.assert.no:isSpawned()
        end)

        it('drop the red fragment for a blunt killing blow on a Skeleton Scuffler', function()
            local scuffler = player.entities:get('Skeleton_Scuffler')
            nightfall(scuffler)
            scuffler.assert:isSpawned()

            killWith(scuffler, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
            player.assert:hasKI(xi.keyItem.LUMINOUS_RED_FRAGMENT)
        end)

        it('drop the green fragment for a piercing killing blow on a Holey Horror', function()
            local horror = player.entities:get('Holey_Horror')
            nightfall(horror)
            horror.assert:isSpawned()

            killWith(horror, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
            player.assert:hasKI(xi.keyItem.LUMINOUS_GREEN_FRAGMENT)
        end)

        it('drop the beige fragment for fire magic on Blest Bones', function()
            local bones = player.entities:get('Blest_Bones')
            nightfall(bones)
            bones.assert:isSpawned()

            killWith(bones, xi.attackType.MAGICAL, xi.damageType.FIRE)
            player.assert:hasKI(xi.keyItem.LUMINOUS_BEIGE_FRAGMENT)
        end)
    end)
end)
