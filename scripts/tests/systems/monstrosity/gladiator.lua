-----------------------------------
-- The gladiator menu the Suspicious NPCs open after the Monstrosity quest. Option values are
-- read from the client's event 887.
-----------------------------------
local ffi = require('ffi')

describe('Monstrosity gladiator menu', function()
    local writ = xi.keyItem.GLADIATORIAL_WRIT_OF_SUMMONS

    ---@type CClientEntityPair
    local player

    -- Talking to the Suspicious Hume after the quest opens the city menus.
    local function openMenus()
        player:gotoZone(xi.zone.PASHHOW_MARSHLANDS)
        player.entities:gotoAndTrigger('Suspicious_Hume', { eventId = 45 })
        player:gotoZone(xi.zone.NORTHERN_SAN_DORIA)
    end

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        -- Rumors from the West and Rhapsodies of Vana'diel play their own cutscenes on entering a city.
        xi.test.world:setSetting('main.ENABLE_SOA', 0)
        xi.test.world:setSetting('main.ENABLE_ROV', 0)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.NORTHERN_SAN_DORIA })
        player:completeQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MONSTROSITY)
    end)

    -- Event 886 is the introduction.
    it('plays the introduction before the Hume has been spoken to', function()
        player.entities:gotoAndTrigger('Suspicious_Elvaan', { eventId = 886 })
    end)

    it('hands out and takes back the writ', function()
        openMenus()

        player.entities:gotoAndTrigger('Suspicious_Elvaan', { eventId = 887, finishOption = 123 })
        player.assert:hasKI(writ)

        player.entities:gotoAndTrigger('Suspicious_Elvaan', { eventId = 887, finishOption = 321 })
        player.assert.no:hasKI(writ)
    end)

    it('announces the returned writ', function()
        openMenus()
        player:addKeyItem(writ)
        player.packets:clear()

        player.entities:gotoAndTrigger('Suspicious_Elvaan', { eventId = 887, finishOption = 321 })

        local lost = false
        for _, pkt in pairs(player.packets:getIncoming()) do
            -- The top bit of the message number is a flag.
            if
                pkt.type == 0x02A and
                bit.band(pkt.data[0x1A] + pkt.data[0x1B] * 256, 0x7FFF) == zones[xi.zone.NORTHERN_SAN_DORIA].text.KEYITEM_LOST
            then
                lost = true
            end
        end

        assert(lost, 'returning the writ said nothing')
    end)

    -- The menu shows param 1 as the prestige held. Retail sent banter line 1 in param 2.
    it('opens the menu with the writ, prestige and banter line', function()
        openMenus()
        player:addKeyItem(writ)
        player:addCurrency('prestige', 1234)
        player.packets:clear()

        player.entities:gotoAndTrigger('Suspicious_Elvaan', { eventId = 887 })

        local params = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x034 then
                params =
                {
                    pkt.data[0x08],
                    pkt.data[0x0C] + pkt.data[0x0D] * 256,
                    pkt.data[0x10],
                }
            end
        end

        assert(params, 'no menu event')
        assert(params[1] == 1 and params[2] == 1234 and params[3] == 1, string.format('menu params were %d, %d, %d', params[1], params[2], params[3]))
    end)

    it('exchanges prestige for an Alloy Tonic', function()
        openMenus()
        player:addKeyItem(writ)
        player:addCurrency('prestige', 6000)

        player.entities:gotoAndTrigger('Suspicious_Elvaan', { eventId = 887, finishOption = 1 })

        assert(player:hasItem(xi.item.PHIAL_OF_ALLOY_TONIC), 'no Alloy Tonic')
        assert(player:getCurrency('prestige') == 1000, string.format('%d prestige left', player:getCurrency('prestige')))
    end)

    it('refuses an exchange without the writ', function()
        openMenus()
        player:addCurrency('prestige', 30000)

        player.entities:gotoAndTrigger('Suspicious_Elvaan', { eventId = 887, finishOption = 1 + bit.lshift(6, 16) })

        assert(not player:hasItem(xi.item.GOETIC_TORQUE), 'exchanged without the writ')
        assert(player:getCurrency('prestige') == 30000, 'prestige was spent')
    end)

    it('refuses an exchange the player cannot afford', function()
        openMenus()
        player:addKeyItem(writ)
        player:addCurrency('prestige', 24999)

        player.entities:gotoAndTrigger('Suspicious_Elvaan', { eventId = 887, finishOption = 1 + bit.lshift(6, 16) })

        assert(not player:hasItem(xi.item.GOETIC_TORQUE), 'exchanged for too little prestige')
        assert(player:getCurrency('prestige') == 24999, 'prestige was taken')
    end)

    it('caps a writ holder in a Belligerency zone', function()
        player:changeJob(xi.job.WAR)
        player:setLevel(75)
        player:addKeyItem(writ)
        player:gotoZone(xi.zone.XARCABARD)

        assert(player:getMainLvl() == 60, string.format('a level 75 gladiator is level %d in Xarcabard', player:getMainLvl()))
    end)

    it('gives a writ holder Gestation on entering a Belligerency zone', function()
        player:addKeyItem(writ)
        player:gotoZone(xi.zone.BUBURIMU_PENINSULA)

        player.assert:hasEffect(xi.effect.GESTATION)
        assert(player:getStatusEffect(xi.effect.GESTATION):getTimeRemaining() <= 60000, 'Gestation lasts over a minute')
    end)

    -- Retail locks every slot for 10 s after a gear change.
    describe('gear changes', function()
        local function equipDagger()
            player:addItem(xi.item.BRONZE_DAGGER)
            local slot = player:findItem(xi.item.BRONZE_DAGGER):getSlotID()
            player.actions:equipSet({ { index = slot, kind = xi.slot.MAIN, container = xi.inv.INVENTORY } })
        end

        before_each(function()
            player:changeJob(xi.job.WAR)
            player:setLevel(30)
        end)

        it('encumber a writ holder in a Belligerency zone', function()
            player:addKeyItem(writ)
            player:gotoZone(xi.zone.BUBURIMU_PENINSULA)
            equipDagger()

            player.assert:hasEffect(xi.effect.ENCUMBRANCE_II)
            assert(player:getStatusEffect(xi.effect.ENCUMBRANCE_II):getPower() == 0xFFFF, 'not every slot is locked')
        end)

        it('keep the locked gear on through an unequip request', function()
            player:addKeyItem(writ)
            player:gotoZone(xi.zone.BUBURIMU_PENINSULA)
            equipDagger()
            player.assert:hasEffect(xi.effect.ENCUMBRANCE_II)

            player.actions:equipSet({ { index = 0, kind = xi.slot.MAIN, container = xi.inv.INVENTORY } })

            assert(player:getEquipID(xi.slot.MAIN) == xi.item.BRONZE_DAGGER, 'unequipped under Encumbrance')
        end)

        it('leave a writ holder outside the Belligerency zones alone', function()
            player:addKeyItem(writ)
            equipDagger()

            player.assert.no:hasEffect(xi.effect.ENCUMBRANCE_II)
        end)
    end)

    it('refuses Trusts to a writ holder', function()
        player:addKeyItem(writ)

        assert(xi.trust.canCast(player, nil) == xi.msg.basic.TRUST_NO_CAST_TRUST, 'a gladiator could call a Trust')
    end)

    -- JP wiki: a tenth of kill exp in the Belligerency zones, only while holding the writ.
    describe('prestige', function()
        local function killCrawler()
            local gained = 0
            player:addListener('EXPERIENCE_POINTS', 'TEST_PRESTIGE_EXP', function(_, _, exp)
                gained = gained + exp
            end)

            local mob = player.entities:moveTo('Carnivorous_Crawler')
            mob:respawn()
            mob:setMobLevel(player:getMainLvl())
            mob:updateClaim(player)
            mob:takeDamage(mob:getHP(), player, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
            for _ = 1, 3 do
                xi.test.world:tickEntity(mob)
                xi.test.world:skipTime(1)
            end

            player:removeListener('TEST_PRESTIGE_EXP')

            return gained
        end

        before_each(function()
            player:changeJob(xi.job.WAR)
            player:setLevel(20)
        end)

        it('pays a tenth of kill exp to a writ holder', function()
            player:addKeyItem(writ)
            player:gotoZone(xi.zone.BUBURIMU_PENINSULA)

            local exp = killCrawler()
            assert(exp > 0, 'precondition: the kill paid no exp')
            assert(player:getCurrency('prestige') == math.floor(exp / 10), string.format('%d exp paid %d prestige', exp, player:getCurrency('prestige')))
        end)

        it('pays nothing without the writ', function()
            player:gotoZone(xi.zone.BUBURIMU_PENINSULA)

            assert(killCrawler() > 0, 'precondition: the kill paid no exp')
            assert(player:getCurrency('prestige') == 0, string.format('earned %d prestige', player:getCurrency('prestige')))
        end)

        -- Retail paid a level 99 capped to 30 a tenth of its limit points.
        it('pays a tenth of limit points to a capped level 99', function()
            player:setLevel(99)
            local meritMode = ffi.new('uint8_t[12]')
            meritMode[4] = 2
            meritMode[5] = 1
            player.packets:send(0x0BE, meritMode, assert(ffi.sizeof(meritMode)))
            player:addKeyItem(writ)
            player:gotoZone(xi.zone.BUBURIMU_PENINSULA)
            assert(player:getMainLvl() == 30, string.format('precondition: level is %d', player:getMainLvl()))

            player.packets:clear()
            local points = killCrawler()
            local limitMessage = false
            for _, pkt in pairs(player.packets:getIncoming()) do
                if
                    pkt.type == 0x02D and
                    bit.band(pkt.data[24] + pkt.data[25] * 256, 0x7FFF) == xi.msg.basic.LIMIT_POINTS_GAINED
                then
                    limitMessage = true
                end
            end

            assert(limitMessage, 'precondition: the kill paid exp, not limit points')
            assert(player:getCurrency('prestige') == math.floor(points / 10), string.format('%d limit points paid %d prestige', points, player:getCurrency('prestige')))
        end)

        -- Retail's Records of Eminence limit point reward paid no prestige.
        it('pays nothing for scripted exp', function()
            player:addKeyItem(writ)
            player:gotoZone(xi.zone.BUBURIMU_PENINSULA)

            player:addExp(600)
            assert(player:getCurrency('prestige') == 0, string.format('scripted exp paid %d prestige', player:getCurrency('prestige')))
        end)

        it('stops kill prestige at 10,000', function()
            player:addKeyItem(writ)
            player:addCurrency('prestige', 9999)
            player:gotoZone(xi.zone.BUBURIMU_PENINSULA)

            killCrawler()
            assert(player:getCurrency('prestige') == 10000, string.format('prestige is %d', player:getCurrency('prestige')))
        end)
    end)

    -- Event 64 is the refusal.
    it('refuses a rental chocobo to a writ holder', function()
        player:changeJob(xi.job.WAR)
        player:setLevel(30)
        player:addKeyItem(xi.keyItem.CHOCOBO_LICENSE)
        player:addKeyItem(writ)
        player:gotoZone(xi.zone.BASTOK_MINES)

        player.entities:gotoAndTrigger('Azette', { eventId = 64 })
    end)
end)
