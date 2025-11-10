-----------------------------------
-- Area: Phomiuna Aqueducts
--  Mob: Minotaur
-----------------------------------
mixins = { require('scripts/mixins/fomor_hate') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('fomorHateAdj', 2)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 25)
end

entity.onMobFight = function(mob, target)
    -- Draws in alliance to a random set of fixed positions if they are south of z=290
    local drawInPositions =
    {
        { x = 65.31, y = 1.00, z = 295.64 },
        { x = 60.40, y = 1.00, z = 295.64 },
        { x = 55.13, y = 1.00, z = 295.64 },
        { x = 65.31, y = 1.00, z = 300.00 },
        { x = 60.40, y = 1.00, z = 300.00 },
        { x = 55.13, y = 1.00, z = 300.00 },
        { x = 65.31, y = 1.00, z = 304.64 },
        { x = 60.40, y = 1.00, z = 304.64 },
        { x = 55.13, y = 1.00, z = 304.64 },
    }

    local drewIn = false
    for _, member in ipairs(target:getAlliance()) do
        local randomPos = drawInPositions[math.random(#drawInPositions)]
        randomPos.rot = member:getRotPos()

        if utils.drawIn(member, { conditions = { member:getZPos() < 290 }, position = randomPos }) then
            drewIn = true
        end
    end

    -- Draw in triggers TP move
    if drewIn then
        mob:useMobAbility()
    end
end

return entity
