-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Qiqirn Mine
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    local chars = instance:getChars()
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setAutoAttackEnabled(false)

    for _, players in pairs(chars) do
        players:timer(1000, function(playersArg)
            playersArg:messageSpecial(ID.text.MINE_COUNTDOWN, 10)
        end)

        players:timer(6000, function(playersArg)
            playersArg:messageSpecial(ID.text.MINE_COUNTDOWN, 5)
        end)

        players:timer(7000, function(playersArg)
            playersArg:messageSpecial(ID.text.MINE_COUNTDOWN, 4)
        end)

        players:timer(8000, function(playersArg)
            playersArg:messageSpecial(ID.text.MINE_COUNTDOWN, 3)
        end)

        players:timer(9000, function(playersArg)
            playersArg:messageSpecial(ID.text.MINE_COUNTDOWN, 2)
        end)

        players:timer(10000, function(playersArg)
            playersArg:messageSpecial(ID.text.MINE_COUNTDOWN, 1)
        end)

        players:timer(11000, function(playersArg)
            playersArg:messageSpecial(ID.text.MINE_COUNTDOWN, 0)
        end)
    end

    -- The countdown always runs, but the mine only goes off if someone is engaged to the rock when it detonates
    -- TODO: Only have ability used if player who used it is engaged.
    -- TODO: The bomb animation should happen immediately. It appears to be delayed.
    mob:timer(11000, function(mobArg)
        mobArg:useMobAbility(xi.mobSkill.MINE_BLAST)
    end)
end

return entity
