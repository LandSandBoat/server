-- The gladiator menu the Suspicious NPCs open after the Monstrosity quest. Option values are
-- read from the client's event 887.
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
