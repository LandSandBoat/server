-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Ash Dragon
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(259200, 432000))

    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
end

entity.onMobFight = function(mob, target)
    -- Ash Dragon will not allow you to pull him through either tunnel exit
    local drawInTable =
    {
        conditions =
        {
            target:getZPos() < 66,
            target:getXPos() < -299
        },
        position = mob:getPos(),
        wait = 5,
    }

    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.DRAGON_ASHER)
    end
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(259200, 432000)) -- 3 to 5 days
end

return entity
