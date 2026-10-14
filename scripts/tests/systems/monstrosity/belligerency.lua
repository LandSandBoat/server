-----------------------------------
-- A Monipulator and a gladiator meeting in a Belligerency zone, from a retail capture of both sides.
-----------------------------------
local ffi     = require('ffi')
local helpers = require('scripts.tests.systems.monstrosity.helpers')

describe('Monstrosity Belligerency', function()
    ---@type CClientEntityPair
    local monipulator

    ---@type CClientEntityPair
    local gladiator

    -- Both arrive in Buburimu Peninsula with Gestation, which shields them until it is clicked off.
    local function meet(flagged)
        monipulator = helpers.spawnMonipulator(xi.zone.BUBURIMU_PENINSULA)
        monipulator:setBelligerencyFlag(flagged)
        monipulator:delStatusEffect(xi.effect.GESTATION)

        gladiator = xi.test.world:spawnPlayer({ zone = xi.zone.BUBURIMU_PENINSULA })
        gladiator:addKeyItem(xi.keyItem.GLADIATORIAL_WRIT_OF_SUMMONS)
        gladiator:gotoZone(xi.zone.BUBURIMU_PENINSULA)
        gladiator:delStatusEffect(xi.effect.GESTATION)
        gladiator:setPos(monipulator:getXPos() + 1, monipulator:getYPos(), monipulator:getZPos())
    end

    -- The message number of every 0x029 the player received.
    local function battleMessages(player)
        local messages = {}
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x029 then
                table.insert(messages, pkt.data[0x18] + pkt.data[0x19] * 256)
            end
        end

        return messages
    end

    -- The message number of every 0x009 the player received.
    local function standardMessages(player)
        local messages = {}
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x009 then
                table.insert(messages, pkt.data[0x0A] + pkt.data[0x0B] * 256)
            end
        end

        return messages
    end

    local function defeat(loser, winner)
        loser:takeDamage(loser:getHP(), winner, xi.attackType.MAGICAL, xi.damageType.ICE)
        for _ = 1, 3 do
            xi.test.world:tickEntity(loser)
            xi.test.world:skipTime(1)
        end
    end

    -- Whether the attacker engaged the target within a few ticks.
    local function engages(attacker, target)
        attacker.actions:engage(target)
        for _ = 1, 3 do
            xi.test.world:tickEntity(attacker)
            if attacker:getTarget() and attacker:getTarget():getID() == target:getID() then
                return true
            end
        end

        return false
    end

    -- Both sides stand beside it. A move packet over that distance would be refused.
    local function spawnDhalmel()
        local mob = monipulator.entities:moveTo('Bull_Dhalmel')
        mob:respawn()
        mob:setUnkillable(true)
        gladiator.entities:moveTo(mob:getID())

        return mob
    end

    it('lets a gladiator attack a flagged Monipulator', function()
        meet(true)

        assert(engages(gladiator, monipulator), 'the gladiator did not engage')
    end)

    -- Retail answers with msg 446, "You cannot attack that target."
    it('refuses a gladiator attacking an unflagged Monipulator', function()
        meet(false)
        gladiator.packets:clear()

        assert(not engages(gladiator, monipulator), 'the gladiator engaged an unflagged Monipulator')
        assert(utils.contains(xi.msg.basic.CANNOT_ATTACK_TARGET, battleMessages(gladiator)), 'no refusal message')
    end)

    it('lets a flagged Monipulator attack a gladiator', function()
        meet(true)

        assert(engages(monipulator, gladiator), 'the Monipulator did not engage')
    end)

    it('refuses an unflagged Monipulator attacking a gladiator', function()
        meet(false)

        assert(not engages(monipulator, gladiator), 'an unflagged Monipulator engaged a gladiator')
    end)

    -- Belligerency changes nothing against monsters, for either side.
    for _, flagged in ipairs({ true, false }) do
        local state = flagged and 'flagged' or 'unflagged'

        it(string.format('lets a %s Monipulator attack a monster', state), function()
            meet(flagged)

            assert(engages(monipulator, spawnDhalmel()), 'the Monipulator did not engage the monster')
        end)

        it(string.format('lets a gladiator attack a monster beside a %s Monipulator', state), function()
            meet(flagged)
            local mob = spawnDhalmel()

            assert(engages(gladiator, mob), 'the gladiator did not engage the monster')
        end)
    end

    it('keeps a Monipulator off a monster a gladiator claimed', function()
        meet(true)
        local mob = spawnDhalmel()
        mob:updateClaim(gladiator)

        assert(not engages(monipulator, mob), 'the Monipulator engaged a monster the gladiator claimed')
    end)

    it('keeps a gladiator off a monster a Monipulator claimed', function()
        meet(true)
        local mob = spawnDhalmel()
        mob:updateClaim(monipulator)

        assert(not engages(gladiator, mob), 'the gladiator engaged a monster the Monipulator claimed')
    end)

    it('lets a Monipulator attack a monster it claimed', function()
        meet(true)
        local mob = spawnDhalmel()
        mob:updateClaim(monipulator)

        assert(engages(monipulator, mob), 'the Monipulator did not engage its own claim')
    end)

    it('lets a gladiator attack a monster it claimed', function()
        meet(true)
        local mob = spawnDhalmel()
        mob:updateClaim(gladiator)

        assert(engages(gladiator, mob), 'the gladiator did not engage its own claim')
    end)

    it('keeps a Monipulator under Gestation out of reach', function()
        meet(true)
        monipulator:addStatusEffect(xi.effect.GESTATION, { duration = 60, origin = monipulator })

        assert(not engages(gladiator, monipulator), 'the gladiator engaged a Monipulator under Gestation')
    end)

    -- JP wiki: any hostile action stops Relinquish, a gladiator's included.
    it('stops Relinquish when a gladiator attacks', function()
        meet(true)
        monipulator:setMonstrosityEntryData(0, 0, 0, 0, xi.zone.WEST_RONFAURE, xi.job.WAR, xi.job.WAR)
        xi.monstrosity.relinquishOnAbility(monipulator)
        gladiator.actions:engage(monipulator)
        for _ = 1, 15 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(gladiator)
            xi.test.world:tickEntity(monipulator)
        end

        assert(monipulator:getMainJob() == xi.job.MON, 'Relinquish carried on while a gladiator attacked')
    end)

    -- Retail: a Monipulator holding 616 infamy lost 61 to a gladiator holding no prestige, who gained nothing.
    it('takes only a tenth of the infamy when the gladiator holds no prestige', function()
        meet(true)
        monipulator:addCurrency('infamy', 616)
        defeat(monipulator, gladiator)

        assert(monipulator:getCurrency('infamy') == 555, string.format('%d infamy left', monipulator:getCurrency('infamy')))
        assert(gladiator:getCurrency('prestige') == 0, string.format('the gladiator gained %d prestige', gladiator:getCurrency('prestige')))
    end)

    -- JP wiki: the winner takes up to a fifth of the loser's points, capped at twice its own.
    it('moves up to a fifth of the infamy to the gladiator', function()
        meet(true)
        monipulator:addCurrency('infamy', 1000)
        gladiator:addCurrency('prestige', 50)
        defeat(monipulator, gladiator)

        assert(monipulator:getCurrency('infamy') == 800, string.format('%d infamy left', monipulator:getCurrency('infamy')))
        assert(gladiator:getCurrency('prestige') == 150, string.format('%d prestige held', gladiator:getCurrency('prestige')))
    end)

    it('moves prestige to the Monipulator that defeats a gladiator', function()
        meet(true)
        gladiator:addCurrency('prestige', 1000)
        monipulator:addCurrency('infamy', 5000)
        defeat(gladiator, monipulator)

        assert(gladiator:getCurrency('prestige') == 700, string.format('%d prestige left', gladiator:getCurrency('prestige')))
        assert(monipulator:getCurrency('infamy') == 5200, string.format('%d infamy held', monipulator:getCurrency('infamy')))
    end)

    -- Retail answers like a monster check: level 13 and too weak with high defense, msg 173. The Monipulator sees MsgStd 89.
    it('answers a /check on a Monipulator like one on a monster', function()
        meet(false)
        gladiator.packets:clear()
        monipulator.packets:clear()

        local packet = ffi.new('uint8_t[16]')
        ffi.cast('uint32_t*', packet + 0x04)[0] = monipulator:getID()
        ffi.cast('uint16_t*', packet + 0x08)[0] = monipulator:getTargID()
        gladiator.packets:send(0x0DD, packet, assert(ffi.sizeof(packet)))

        local level = nil
        for _, pkt in pairs(gladiator.packets:getIncoming()) do
            if pkt.type == 0x029 then
                level = pkt.data[0x0C]
            end
        end

        assert(level == monipulator:getMainLvl(), string.format('the check reported level %s', tostring(level)))
        assert(utils.contains(89, standardMessages(monipulator)), 'the Monipulator was not told it was examined')
    end)

    -- Retail: MsgStd 28, "You cannot trade with that target."
    it('refuses a trade to a Monipulator', function()
        meet(false)
        gladiator.packets:clear()
        gladiator.actions:tradeRequest(monipulator)

        assert(utils.contains(28, standardMessages(gladiator)), 'no refusal message')
    end)

    -- Retail: 0x022 kind 4, which the client prints as "You cannot trade with <name> at this time."
    it('refuses a trade from a Monipulator', function()
        meet(false)
        monipulator.packets:clear()
        monipulator.actions:tradeRequest(gladiator)

        local kind = nil
        for _, pkt in pairs(monipulator.packets:getIncoming()) do
            if pkt.type == 0x022 then
                kind = pkt.data[0x08]
            end
        end

        assert(kind == 4, string.format('trade reply kind %s', tostring(kind)))
    end)
end)
