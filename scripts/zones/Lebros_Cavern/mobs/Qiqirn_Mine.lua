-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Qiqirn Mine
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()
    local chars = instance:getChars()
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setAutoAttackEnabled(false)

    for _, players in pairs(chars) do
        players:messageSpecial(ID.text.MINE_COUNTDOWN, 10)
        players:timer(5000, function(playersArg)
            playersArg:messageSpecial(ID.text.MINE_COUNTDOWN, 5)
        end)

        players:timer(6000, function(playersArg)
            playersArg:messageSpecial(ID.text.MINE_COUNTDOWN, 4)
        end)

        players:timer(7000, function(playersArg)
            playersArg:messageSpecial(ID.text.MINE_COUNTDOWN, 3)
        end)

        players:timer(8000, function(playersArg)
            playersArg:messageSpecial(ID.text.MINE_COUNTDOWN, 2)
        end)

        players:timer(9000, function(playersArg)
            playersArg:messageSpecial(ID.text.MINE_COUNTDOWN, 1)
        end)
    end

    mob:timer(9000, function(mobArg)
        mobArg:useMobAbility(1838)
    end)

    mob:timer(11000, function(mobArg)
        mobArg:setHP(0)
    end)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
