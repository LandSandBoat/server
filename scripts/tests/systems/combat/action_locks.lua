describe('Actions during events', function()
    ---@type CClientEntityPair
    local player
    ---@type CTestEntity
    local mob

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.BEAUCEDINE_GLACIER_S, job = xi.job.BLM, level = 75 })
        mob    = player.entities:moveTo('Ruszor')
        player:addSpell(xi.magic.spell.STONE)
    end)

    it('lands a spell when not in an event', function()
        local hpBefore = mob:getHP()

        player.actions:useSpell(mob, xi.magic.spell.STONE)
        xi.test.world:skipTime(5)

        assert(mob:getHP() < hpBefore, 'control cast did not land')
    end)

    it('refuses a spell while in an event', function()
        player:startEvent(1)
        assert(player:isInEvent(), 'event did not start')

        local hpBefore = mob:getHP()

        player.actions:useSpell(mob, xi.magic.spell.STONE)
        xi.test.world:skipTime(5)

        assert(mob:getHP() >= hpBefore, 'spell landed during an event')
    end)

    it('refuses to engage while in an event', function()
        player:startEvent(1)

        player.actions:engage(mob)
        xi.test.world:skipTime(1)

        assert(not player:isEngaged(), 'engaged during an event')
    end)
end)

describe('Equipment during weaponskills', function()
    ---@type CClientEntityPair
    local player
    ---@type CTestEntity
    local mob

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.BEAUCEDINE_GLACIER_S, job = xi.job.WAR, level = 75 })
        mob    = player.entities:moveTo('Ruszor')

        player:setSkillLevel(xi.skill.SWORD, 200)
        player:addItem(xi.item.BRONZE_SWORD)
        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        player:addItem(xi.item.BRONZE_DAGGER)
    end)

    local function swapToDagger()
        local slot = player:findItem(xi.item.BRONZE_DAGGER):getSlotID()
        player.actions:equipSet({ { index = slot, kind = xi.slot.MAIN, container = xi.inv.INVENTORY } })
    end

    it('keeps the weapon that started the weaponskill until it resolves', function()
        player:setTP(3000)
        player.actions:engage(mob)
        player.actions:useWeaponskill(mob, xi.weaponskill.FAST_BLADE)

        swapToDagger()
        assert(player:getEquipID(xi.slot.MAIN) == xi.item.BRONZE_SWORD, 'main weapon changed mid-weaponskill')

        xi.test.world:skipTime(5)
        -- one more tick so the finished weaponskill state is popped
        xi.test.world:skipTime(5)

        swapToDagger()
        assert(player:getEquipID(xi.slot.MAIN) == xi.item.BRONZE_DAGGER, 'main weapon still locked after the weaponskill resolved')
    end)
end)
