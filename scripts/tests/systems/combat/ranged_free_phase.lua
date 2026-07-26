-----------------------------------
-- TEST: Ensures the player cannot ranged attack again inside of phase 3 ranged attack delay
-----------------------------------
describe('Ranged Attack Free Phase Delay', function()
    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local target

    local function bulletCount()
        local ammo = player:getEquippedItem(xi.slot.AMMO)
        if ammo == nil then
            return 0
        end

        return ammo:getQuantity()
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.THF, level = 99 })
        target = player.entities:moveTo('Wild_Rabbit')
        target:respawn()
        target:setUnkillable(true)
        target:setBaseSpeed(0)

        local pos = target:getPos()
        player:setPos(pos.x - 5, pos.y, pos.z, 0)
        player:lookAt(target:getPos())

        player:addItem(xi.item.PLATOON_GUN)
        player:addItem(xi.item.BULLET, 99)
        player:equipItem(xi.item.PLATOON_GUN)
        player:equipItem(xi.item.BULLET)
    end)

    -- skipTime() places a 400ms tick on top of each call, this is 6.2s, need to do this because the timing of this test is very specific.
    it('cannot perform another ranged attack inside of free phase window', function()
        player.actions:rangedAttack(target)
        xi.test.world:skipTime(3)
        xi.test.world:skipTime(1)
        xi.test.world:skipTime(1)
        assert(bulletCount() == 98, 'the first shot should fire and consume a bullet')

        player.actions:rangedAttack(target)
        xi.test.world:skipTime(6)
        assert(bulletCount() == 98, 'a shot attempted inside the free phase should not fire')

        player.actions:rangedAttack(target)
        xi.test.world:skipTime(6)
        assert(bulletCount() == 97, 'a shot attempted after the free phase should fire')
    end)
end)
